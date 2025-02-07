extends Node2D

var dialog_box = preload("res://Scenes/DialogBox/DialogBox.tscn")
@export var worldState: Resource

func _ready():
	if NavigationManager.spawn_door_tag!=null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _input(event: InputEvent) -> void:
	if self.name=="Level3":
		if event.is_action_released("ui_accept"):
			for child in $HUD.get_children():
				child.queue_free()

func _on_level_spawn(destination_tag : String):
	var door_path= "Doors/door_"+destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position,door.spawn_direction)
	
	if self.name == "Level3":
		if worldState:
			if worldState.sword_unlocked:
				pass
			else :
				$HUD.add_child(dialog_box.instantiate())
				$HUD/DialogBox.print("'Mais ou est mon Steak ?'\nUn garde cherche un steak")


func _on_chest_4_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
