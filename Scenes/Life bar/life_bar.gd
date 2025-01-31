extends CanvasLayer

@export var playerState: Resource

var hearts = [
	preload("res://Assets/Sprite/heart/0.png"),
	preload("res://Assets/Sprite/heart/1.png"),
	preload("res://Assets/Sprite/heart/2.png"),
	preload("res://Assets/Sprite/heart/3.png"),
	preload("res://Assets/Sprite/heart/4.png"),
	preload("res://Assets/Sprite/heart/5.png"),
]

func _ready() -> void:
	playerState.health_change.connect(_on_health_change)
	get_node("HeartSprite").texture = hearts[playerState.health]

func _process(delta: float) -> void:
	if Input.is_action_just_released("take_damage"):
		playerState.take_damage(1)

func _on_health_change(old_value, new_value):
	get_node("HeartSprite").texture = hearts[new_value]
