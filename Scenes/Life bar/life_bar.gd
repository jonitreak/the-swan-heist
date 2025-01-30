extends Node2D

var hearts = [
	preload("res://Assets/Sprite/heart/0.png"),
	preload("res://Assets/Sprite/heart/1.png"),
	preload("res://Assets/Sprite/heart/2.png"),
	preload("res://Assets/Sprite/heart/3.png"),
	preload("res://Assets/Sprite/heart/4.png"),
	preload("res://Assets/Sprite/heart/5.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_health_changed(new_value: int) -> void:
	if new_value < 6 and new_value > 0:
		get_node("Sprite2D").texture = hearts[new_value]
