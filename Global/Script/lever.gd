extends Area2D
class_name Lever

@onready var bridge=self.get_parent().get_node("Bridge")
@onready var lava=self.get_parent().get_node("LavaUnderBridge")
@onready var leverAnimation=$AnimatedSprite2D
var activated:bool

func _ready():
	self.visible=true
	bridge.visible=false
	leverAnimation.play("off")
	activated=false
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if activated==false:
			activated=true
			leverAnimation.play("Switch")
			var timer = get_tree().create_timer(0.5)
			await timer.timeout
			leverAnimation.play("On")
			bridge.visible=true
			lava.collision_enabled=false
