extends Node

var health: int = 5
signal health_change(old_value, new_value)
signal death()

func take_damage(amount: int):
	if amount > 0 and amount < 6:
		if health > amount:
			var old_health = health
			health -= amount
			health_change.emit(old_health, health)
		else:
			var old_health = health
			health = 0
			health_change.emit(old_health, 0)
			death.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_released("take_damage"):
		take_damage(1)
