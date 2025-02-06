extends Node2D
class_name Mob

@export var direction_angle : float = 0.0
@onready var sfx_hurt = $AudioStreamPlayer2D


var animations : Dictionary = {
	"right" : "MobIdleRight",
	"up_right" : "MobIdleUpRight",
	"up" : "MobIdleUp",
	"up_left" : "MobIdleUpLeft",
	"left" : "MobIdleLeft",
	"down_left" : "MobIdleDownLeft",
	"down" : "MobIdleDown",
	"down_right" : "MobIdleDownRight"
}

var hurtAnimations : Dictionary = {
	"right" : "MobHurtRight",
	"up_right" : "MobHurtUpRight",
	"up" : "MobHurtUp",
	"up_left" : "MobHurtUpLeft",
	"left" : "MobHurtLeft",
	"down_left" : "MobHurtDownLeft",
	"down" : "MobHurtDown",
	"down_right" : "MobHurtDownRight"
}
var pv=100


func get_direction_angle():
	return direction_angle
	
func isVisible():
	return visible

func _ready():
	update_animation()

func update_animation() -> void:
	var direction = get_direction_from_angle(direction_angle)
	var animation_name = animations.get(direction, "MobIdleDown")
	play_animation(animation_name)

func hurt_animation()->void:
	var direction = get_direction_from_angle(direction_angle)
	var animation_name = hurtAnimations.get(direction, "MobHurtDown")
	play_animation(animation_name)
	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	animation_name = animations.get(direction, "MobIdleDown")
	play_animation(animation_name)


func get_direction_from_angle(angle : float) -> String:
	if angle >= -22.5 and angle < 22.5:
		return "right"
	elif angle >= 22.5 and angle < 67.5:
		return "up_right"
	elif angle >= 67.5 and angle < 112.5:
		return "up"
	elif angle >= 112.5 and angle < 157.5:
		return "up_left"
	elif angle >= 157.5 or angle < -157.5:
		return "left"
	elif angle >= -157.5 and angle < -112.5:
		return "down_left"
	elif angle >= -112.5 and angle < -67.5:
		return "down"
	elif angle >= -67.5 and angle < -22.5:
		return "down_right"
	return "right"

func play_animation(animation_name : String) -> void:
	$AnimatedSprite2D.play(animation_name)

func damage(value=10):
	pv=pv-value 
	print(pv)
	hurt_animation()
	sfx_hurt.play()
	if pv<1: 
		print("dead") 
		var timer = get_tree().create_timer(0.5)
		await timer.timeout
		queue_free()
	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	
