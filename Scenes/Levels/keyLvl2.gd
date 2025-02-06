extends Area2D
class_name Key

@export var worldState: Resource
@onready var sfx_key=$AudioStreamPlayer2D

func _ready():
	self.visible=false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if worldState:
			sfx_key.play()
			worldState.door1_open=true
			self.visible=false
