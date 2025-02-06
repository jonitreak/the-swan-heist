extends Node2D
class_name Ray

@export var player : Player
@export var cone_direction_angle : float = 0.0
@export var mob: Mob
@export var steak_area : Area2D
@export var worldState: Resource

var max_view_distance := 300
var angle_between_rays := deg_to_rad(5.0)
var raycasts : Array = []


signal steak_activated


func _ready():
	if worldState:
		if worldState.sword_unlocked:
			pass
		elif player :
			if mob==null :
				create_raycasts()
			elif mob.visible: 
				create_raycasts()
				steak_area.connect("steak_activated", Callable(self, "_destroy"))
			else: 
				steak_area.connect("steak_activated", Callable(self, "_on_steak"))
	
		
func _destroy():
	for raycast in raycasts:
		raycast.queue_free()  # Supprime tous les RayCasts
	raycasts.clear()  # Vide la liste
	queue_free()  # Supprime le nœud principal
	mob.visible=false

func _on_steak():
	mob.visible=true
	create_raycasts()

func create_raycasts() -> void:
	var ray_count = 6
	for index in range(ray_count):
		var angle = angle_between_rays * (index - (ray_count - 1) / 2.0)
		var direction = Vector2.UP.rotated(deg_to_rad(cone_direction_angle + 180 - (angle_between_rays * ray_count) / 2) + angle) * max_view_distance

		var raycast = RayCast2D.new()
		raycast.position = position
		raycast.target_position = position + direction
		raycast.collide_with_areas = true
		raycast.collide_with_bodies = true
		raycast.enabled = visible
		raycast.collision_mask = 1
		add_child(raycast)
		raycasts.append(raycast)

func _physics_process(delta: float) -> void:
	queue_redraw()
	for raycast in raycasts:
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			print(collider.name)
			if collider is Player:
				print("ok")
				NavigationManager.go_to_level("level1", "0")


func _draw() -> void:
	var cone_points : Array = [position]
	for raycast in raycasts:
		cone_points.append(raycast.target_position)
	draw_polygon(cone_points, [Color(1, 0, 0, 0.3)])
