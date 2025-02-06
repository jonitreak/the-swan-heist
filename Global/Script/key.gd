extends Area2D

@export var worldState: Resource
@onready var sfx_key = $AudioStreamPlayer2D

func _ready():
	if worldState:
		if worldState.key1_obtained:
			self.visible=false
		else:
			self.visible=true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		sfx_key.play()
		worldState.key1_obtained=true
		self.visible=false
