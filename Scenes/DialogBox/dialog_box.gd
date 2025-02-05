extends VBoxContainer


func print(text: String) -> void:
	var node = get_node("NinePatchRect/MarginContainer/Label")
	node.text = text + "\n(Press Enter to continue)"
	
	var font_size = get_viewport().get_visible_rect().size.y / 10
	node.label_settings.font_size = font_size


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
