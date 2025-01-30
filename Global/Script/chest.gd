extends Area2D


signal on_sword_chest_animation_finished
@onready var chest_animation=$ChestAnimation
@onready var sword_obtained_animation=$Sword

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("chest1 ouvert")
		open_chest()


func _ready():
	chest_animation.play("Idle")
	#chest_animation.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name=="Open":
		on_sword_chest_animation_finished.emit()
		chest_animation.play("Opened")
	elif anim_name=="Opened":
		chest_animation.play("Opened")
	
func open_chest(): 
	if chest_animation.get_animation()=="Idle":
		chest_animation.play("Open")
		var timer = get_tree().create_timer(1.5)
		await timer.timeout
		if self.name=="Chest_1":
			sword_obtained_animation._on_sword_obtained()
		chest_animation.play("Opened")
	
