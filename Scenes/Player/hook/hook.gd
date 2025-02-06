extends Node2D

@export var speed: float = 500.0
@onready var player = self.get_parent()
@onready var head = $Head
@onready var raycast = $RayCast2D
@export var tail_scene: PackedScene  # Préfabriqué pour le tail (chaque maillon de la chaîne)

var is_hooking = false
var hook_target_position = null
var hook_target_object = null
var tail_segments = []

func _ready():
	raycast.enabled = true
	self.visible = false
# Exemple de conversion des coordonnées cartésiennes en coordonnées isométriques
# Fonction de conversion en coordonnées isométriques
func cartesian_to_isometric(cartesian_position: Vector2) -> Vector2:
	var iso_x = (cartesian_position.x - cartesian_position.y) * 0.5
	var iso_y = (cartesian_position.x + cartesian_position.y) * 0.5
	return Vector2(iso_x, iso_y)

# Fonction de conversion inverse
func isometric_to_cartesian(iso_position: Vector2) -> Vector2:
	var cart_x = iso_position.x + iso_position.y
	var cart_y = iso_position.y - iso_position.x
	return Vector2(cart_x, cart_y)

func start_hook(direction: Vector2):
	self.visible = true
	is_hooking = true
	
	var raycast_end_pos = direction.normalized() * 1000  # Calculer la fin du raycast

	raycast.target_position = raycast_end_pos 
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		var collider = raycast.get_collider()

		# Convertir la position de l'impact et l'objet en isométrique
		hook_target_position = cartesian_to_isometric(collision_point)
		hook_target_object = collider if collider.is_in_group("hookable") else null
		
		animate_hook()
	else: 
		print("Pas de collision détectée")

# Le reste de ton code, où tu animates la tête du grappin et autres...


func animate_hook():
	clear_tail()
	
	# Calcul de la distance de la queue
	var hook_distance = int((player.position.distance_to(hook_target_position)) / 64)
	
	# Créer les maillons de la queue
	for i in range(1, hook_distance):  # Crée les maillons entre le joueur et le hook
		var tail_instance = tail_scene.instantiate()
		tail_instance.global_position = player.global_position.lerp(hook_target_position, i / float(hook_distance))
		tail_instance.play("visible")
		get_parent().add_child(tail_instance)  # On l'ajoute au niveau, pas au hook
		tail_segments.append(tail_instance)

	# Mises à jour de la tête
	if hook_target_object:  # Si l'objet est hookable
		head.look_at(hook_target_object.global_position)  # La tête du grappin regarde l'objet hooké
		pull_hook_target()  # Déplace l'objet
	else:
		head.look_at(hook_target_position)  # La tête regarde vers la position du grappin
		
	head.play("visible")

func pull_hook_target():
	while is_hooking and hook_target_object:
		var direction = (player.position - hook_target_object.position).normalized()
		hook_target_object.position += direction * speed * get_process_delta_time()
		if hook_target_object.position.distance_to(player.position) < 10:
			stop_hook()
		await get_tree().process_frame  # Permet un déplacement progressif

func clear_tail():
	for segment in tail_segments:
		segment.queue_free()
	tail_segments.clear()

func stop_hook():
	is_hooking = false
	clear_tail()
	head.play("empty")
	self.visible = false
