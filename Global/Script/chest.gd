extends Area2D


signal on_sword_chest_animation_finished
@onready var chest_animation=$ChestAnimation
@onready var sword_obtained_animation=$Sword

@export var worldState: Resource

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		open_chest()


func _ready():
	if worldState.sword_unlocked and self.name=="Chest_1":
		chest_animation.play("Opened")
	else:
		chest_animation.play("Idle")

func _on_animation_finished(anim_name):
	if anim_name=="Open":
		on_sword_chest_animation_finished.emit()
		chest_animation.play("Opened")
	elif anim_name=="Opened":
		chest_animation.play("Opened")
	
func open_chest(): 
	if self.name=="Chest_1":
		if chest_animation.get_animation()=="Idle":
			chest_animation.play("Open")
			var timer = get_tree().create_timer(1.5)
			await timer.timeout
			sword_obtained_animation._on_sword_obtained()
			worldState.sword_unlocked=true
			chest_animation.play("Opened")
	elif self.name=="Chest_2" and worldState.key1_obtained:
		if chest_animation.get_animation()=="Idle":
			chest_animation.play("Open")
			var timer = get_tree().create_timer(1.5)
			await timer.timeout
			#sword_obtained_animation._on_sword_obtained()
			worldState.hook_unlocked=true
			chest_animation.play("Opened")
	
