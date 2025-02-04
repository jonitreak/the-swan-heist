extends Area2D

class_name Door 

@export var destination_level_tag : String
@export var destination_door_tag : String 
@export var spawn_direction := String("up")
@export var worldState: Resource

@onready var spawn=$Spawn

func _on_body_entered(body: Node2D) -> void:
	if self.name!="door_3":
		if body is Player:
			NavigationManager.go_to_level(destination_level_tag,destination_door_tag)
	elif worldState:
		print(worldState.door1_open)
		if worldState.door1_open:
			NavigationManager.go_to_level(destination_level_tag,destination_door_tag)
	else :
		print(self.name)
