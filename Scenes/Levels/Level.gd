extends Node2D

func _ready():
	if NavigationManager.spawn_door_tag!=null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_level_spawn(destination_tag : String):
	var door_path= "Doors/door_"+destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position,door.spawn_direction)


func _on_chest_4_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
