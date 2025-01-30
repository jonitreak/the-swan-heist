extends Area2D

signal steak_activated

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		steak_activated.emit()
		position=Vector2(-140,50)
		print("steak_signal émis")
