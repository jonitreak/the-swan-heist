extends Node2D

@export var speed: float = 500.0
@onready var player=self.get_parent()
@onready var head= $Head
@export var tail_scene: PackedScene  # Préfabriqué pour le tail (chaque maillon de la chaîne)
@onready var raycast = $RayCast2D

var is_hooking = false
var hook_target = null
var tail_segments = []

func _ready():
	raycast.enabled = true
	self.visible=false

func start_hook(direction: Vector2):
	is_hooking = true
	raycast.target_position = direction.normalized() * 10000
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		print("colliding")
		var collider = raycast.get_collider()
		if collider.is_in_group("not_hookable"):
			stop_hook()
		elif collider.is_in_group("hookable"):
			hook_target = collider
			animate_hook()

func animate_hook():
	var hook_distance = int((player.position.distance_to(hook_target.position)) / 64)  # 64 pixels = 1 bloc
	clear_tail()

	for i in range(1, hook_distance):  # Créer les maillons entre le joueur et le hook
		var tail_instance = tail_scene.instantiate()
		tail_instance.position = player.position + (hook_target.position - player.position) * (i / float(hook_distance))
		tail_instance.play("visible")
		add_child(tail_instance)
		tail_segments.append(tail_instance)

	head.position = hook_target.position
	head.play("visible")

func clear_tail():
	for segment in tail_segments:
		segment.queue_free()
	tail_segments.clear()

func stop_hook():
	is_hooking = false
	clear_tail()
	head.play("empty")
