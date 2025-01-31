extends CanvasLayer

var hearts = [
	preload("res://Assets/Sprite/heart/0.png"),
	preload("res://Assets/Sprite/heart/1.png"),
	preload("res://Assets/Sprite/heart/2.png"),
	preload("res://Assets/Sprite/heart/3.png"),
	preload("res://Assets/Sprite/heart/4.png"),
	preload("res://Assets/Sprite/heart/5.png"),
]

func _ready() -> void:
	PlayerState.health_change.connect(_on_health_change)
	get_node("Control/HeartSprite").texture = hearts[PlayerState.health]

func _process(delta: float) -> void:
	pass

func _on_health_change(old_value, new_value):
	get_node("Control/HeartSprite").texture = hearts[new_value]
