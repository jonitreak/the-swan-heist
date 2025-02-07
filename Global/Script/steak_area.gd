extends Area2D

signal steak_activated
@export var worldState: Resource
@onready var sfx_steak=$AudioStreamPlayer2D
var dialog_box = preload("res://Scenes/DialogBox/DialogBox.tscn")

func _ready():
	if worldState:
		if worldState.sword_unlocked:
			self.visible=false
		else:
			self.visible=true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		sfx_steak.play()
		steak_activated.emit()
		position=Vector2(-140,50)
		$HUD.add_child(dialog_box.instantiate())
		$HUD/DialogBox.print("'Oh, mon steak' Le garde est distrait ")
		
func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		for child in $HUD.get_children():
			child.queue_free()
