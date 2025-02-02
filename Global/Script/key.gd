extends Area2D

@export var worldState: Resource

func _ready():
	if worldState:
		if worldState.key1_obtained:
			self.visible=false
		else:
			self.visible=true

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body is Player:
		worldState.key1_obtained=true
		self.visible=false
