extends Area2D

signal steak_activated
@export var worldState: Resource

func _ready():
	if worldState:
		if worldState.sword_unlocked:
			self.visible=false
		else:
			self.visible=true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		steak_activated.emit()
		position=Vector2(-140,50)
