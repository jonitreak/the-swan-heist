extends Area2D
class_name HitBox

var mobs_in_zone = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if body.is_in_group("Mob"):
		mobs_in_zone.append(body)
	print(body)

func _on_body_exited(body):
	if body.is_in_group("Mob"):
		mobs_in_zone.erase(body)

func has_mob_in_zone():
	return mobs_in_zone.size() > 0
