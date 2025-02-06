extends CanvasLayer

signal on_caught_transition_finished
signal on_caught_transition_started

@onready var color_rect=$ColorRect
@onready var animation_player=$AnimationPlayer
@onready var sfx_detected=$AudioStreamPlayer2D

func _ready():
	color_rect.visible=false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name=="fade_to_red":
		on_caught_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name=="fade_to_normal":
		color_rect.visible=false
	
func transition(): 
	sfx_detected.play()
	color_rect.visible=true
	on_caught_transition_started.emit()
	animation_player.play("fade_to_red")
	
