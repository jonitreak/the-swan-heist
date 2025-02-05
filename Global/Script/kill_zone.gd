extends Area2D
signal body_entered_killzone(body,position)
@export var player : Player
@export var key : Key


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var hook=player.get_node("Hook/Tail")
	if body is Mob or body is Block: 
		hook.stop_hooking(body,body.global_position)
		var timer = get_tree().create_timer(1.25)
		await timer.timeout
		key.visible=true
