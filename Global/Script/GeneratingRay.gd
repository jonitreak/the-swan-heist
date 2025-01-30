extends Node2D
class_name Ray

@export var player : Player
@export var cone_direction_angle : float = 0.0

var max_view_distance := 300
var angle_between_rays := deg_to_rad(5.0)
var raycasts : Array = []


func _ready():
	if player:
		create_raycasts()
	else:
		print("Erreur : Player non défini dans l'éditeur !")

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
		raycast.enabled = true
		raycast.collision_mask = 1
		add_child(raycast)
		raycasts.append(raycast)

func _physics_process(delta: float) -> void:
	queue_redraw()
	for raycast in raycasts:
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider == player:
				print("Vu: Player")
				NavigationManager.go_to_level("level1", "0")


func _draw() -> void:
	var cone_points : Array = [position]
	for raycast in raycasts:
		cone_points.append(raycast.target_position)
	draw_polygon(cone_points, [Color(1, 0, 0, 0.3)])
