extends Node2D

@export var speed: float = 500.0
@onready var player = self.get_parent()
@onready var head = $Head
@onready var raycast = $RayCast2D
@export var tail_scene: PackedScene  

var is_hooking = false
var hook_target_position = null
var hook_target_object = null
var tail_segments = []

func _ready():
	raycast.enabled = true
	self.visible = false
func cartesian_to_isometric(cartesian_position: Vector2) -> Vector2:
	var iso_x = (cartesian_position.x - cartesian_position.y) * 0.5
	var iso_y = (cartesian_position.x + cartesian_position.y) * 0.5
	return Vector2(iso_x, iso_y)

func isometric_to_cartesian(iso_position: Vector2) -> Vector2:
	var cart_x = iso_position.x + iso_position.y
	var cart_y = iso_position.y - iso_position.x
	return Vector2(cart_x, cart_y)

func start_hook(direction: Vector2):
	self.visible = true
	is_hooking = true
	
	var raycast_end_pos = direction.normalized() * 1000 

	raycast.target_position = raycast_end_pos 
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		var collider = raycast.get_collider()

		hook_target_position = cartesian_to_isometric(collision_point)
		hook_target_object = collider if collider.is_in_group("hookable") else null
		
		animate_hook()
	else: 
		print("Pas de collision détectée")


func animate_hook():
	clear_tail()
	
	var hook_distance = int((player.position.distance_to(hook_target_position)) / 64)
	
	for i in range(1, hook_distance): 
		var tail_instance = tail_scene.instantiate()
		tail_instance.global_position = player.global_position.lerp(hook_target_position, i / float(hook_distance))
		tail_instance.play("visible")
		get_parent().add_child(tail_instance) 
		tail_segments.append(tail_instance)

	if hook_target_object:  
		head.look_at(hook_target_object.global_position)  
		pull_hook_target() 
	else:
		head.look_at(hook_target_position) 
		
	head.play("visible")

func pull_hook_target():
	while is_hooking and hook_target_object:
		var direction = (player.position - hook_target_object.position).normalized()
		hook_target_object.position += direction * speed * get_process_delta_time()
		if hook_target_object.position.distance_to(player.position) < 10:
			stop_hook()
		await get_tree().process_frame 

func clear_tail():
	for segment in tail_segments:
		segment.queue_free()
	tail_segments.clear()

func stop_hook():
	is_hooking = false
	clear_tail()
	head.play("empty")
	self.visible = false
