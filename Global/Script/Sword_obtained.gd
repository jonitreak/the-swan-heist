extends Node2D

@export var sword_obtained_animation : AnimatedSprite2D
@export var player : Player


func _ready():
	sword_obtained_animation.visible=false

func _on_sword_obtained():
	sword_obtained_animation.visible=true
	sword_obtained_animation.position = player.position + Vector2(0, -50)
	sword_obtained_animation.play("SwordObtained")
	var timer = get_tree().create_timer(2)
	await timer.timeout
	sword_obtained_animation.play("Idle")
	sword_obtained_animation.visible=false
