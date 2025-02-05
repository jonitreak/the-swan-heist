extends Sprite2D

class_name Hook

@onready var ray_cast = $RayCast2D
var distance: float = 150.0
var hooked_object = null  
var player_hook_to = null


func _ready():
	self.rotation=0
	self.visible=0


func normalize_to_angle(direction: Vector2) -> int:
	if direction==Vector2(0,1):
		return 0
	elif direction==Vector2(-1,1):
		return 45
	elif direction==Vector2(-1,0):
		return 90
	elif direction==Vector2(-1,-1):
		return 135
	elif direction==Vector2(0,-1):
		return 180
	elif direction==Vector2(1,-1):
		return 225
	elif direction==Vector2(1,0):
		return 270
	elif direction==Vector2(1,1):
		return 315
	else: 
		return 360

func interpolate(length: float, duration: float = 0.2):
	self.offset = Vector2(0, 32 * length)
	self.region_rect = Rect2(0, 0, 64, 64 * length)
	self.region_enabled = true

func start_hook(direction):
	self.visible = true
	var initial_rotation = self.rotation_degrees
	var angle = normalize_to_angle(direction)
	self.rotation_degrees = angle
	await check_collision()
	interpolate(distance / 8, 0.2)
	await get_tree().create_timer(1).timeout
	
	if hooked_object:
		await pull_object()  # Attire l'objet vers le joueur
		
		reverse_interpolate(distance)
	elif player_hook_to:
		await pull_player()
	self.rotation_degrees = initial_rotation
	self.visible = false

func reverse_interpolate(length):
	interpolate(1 / float(length), 0.75)

func check_collision():
	await get_tree().create_timer(0.1).timeout
	var collision_point

	if ray_cast.is_colliding():
		collision_point = ray_cast.get_collision_point()
		distance = (global_position - collision_point).length()
		var collider = ray_cast.get_collider()
		
		if collider.is_in_group("hookable"):
			hooked_object = collider  
		elif collider.is_in_group("player_hookable"):
			player_hook_to=collider
		else:
			hooked_object = null  
	else:
		distance = 150.0
		hooked_object = null

	
func pull_object():
	var target_position = global_position + Vector2(0, 10)  # Attirer vers le joueur
	while hooked_object and hooked_object.global_position.distance_to(target_position) > 5:
		var direction = (target_position - hooked_object.global_position).normalized()
		hooked_object.global_position += direction * 500 * get_process_delta_time()
		await get_tree().process_frame
	
	# Centrer l'objet sur le bloc isométrique
	if hooked_object:
		hooked_object.global_position = snap_to_iso_grid(hooked_object.global_position)

	hooked_object = null  # Lâche l'objet après l'attraction

func pull_player():
	var player = self.get_parent().get_parent()
	if player:
		var collision_shape = player.get_node("CollisionShape2D")
		collision_shape.set_deferred("disabled", true)
		await get_tree().process_frame
		var pos=player_hook_to.get_node("CollisionShape2D").position	
		#var direction = get_discrete_direction(pos - player.global_position)
		#player.global_position += direction * 500 * get_process_delta_time()
		player.global_position = pos
		await get_tree().process_frame
		#player.global_position = snap_to_iso_grid(player.global_position)
		collision_shape.set_deferred("disabled", false)

	player_hook_to = null  
	
func get_discrete_direction(direction: Vector2) -> Vector2:
	if direction.length() == 0:
		return Vector2.ZERO  # Si pas de mouvement, garder zéro
	
	var discrete_dir = Vector2.ZERO
	
	if abs(direction.x) > abs(direction.y):  # Privilégier l'axe dominant
		discrete_dir.x = 1 if direction.x > 0 else -1
	else:
		discrete_dir.y = 1 if direction.y > 0 else -1
	
	return discrete_dir
	
func snap_to_iso_grid(position: Vector2) -> Vector2:
	var tile_size = Vector2(32, 16)  # Taille d’un bloc en isométrique
	var grid_x = round(position.x / tile_size.x)
	var grid_y = round(position.y / tile_size.y)
	return Vector2(grid_x * tile_size.x, grid_y * tile_size.y)

func stop_hooking(body, position,disapear):
	if hooked_object == body:  
		hooked_object.global_position = position  
		hooked_object = null  
		if disapear:
			var tween = get_tree().create_tween()
			tween.tween_property(body, "scale", Vector2(0, 0), 1.0)  
			await tween.finished
			body.queue_free()
