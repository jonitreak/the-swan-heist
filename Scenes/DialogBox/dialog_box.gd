extends VBoxContainer


func print(text: String) -> void:
	get_node("NinePatchRect/MarginContainer/HBoxContainer/Label").text = text


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
