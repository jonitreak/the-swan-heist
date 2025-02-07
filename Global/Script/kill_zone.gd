extends Area2D
signal body_entered_killzone(body,position)
@export var player : Player
@export var key : Key
@export var worldState: Resource
var hole:TileMapLayer
var closed_hole:TileMapLayer
var switch_door: TileMapLayer
@onready var collisionShape=$CollisionShape2D
@onready var scene=self.get_parent().get_parent()
@onready var sfx_drop= $AudioStreamPlayer2D
@onready var sfx_switch = self.get_node("Switch")
var is_hole:bool
var is_switch:bool
var dialog_box = preload("res://Scenes/DialogBox/DialogBox.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var hook=player.get_node("Hook/Tail")
	if body is Mob: 
		sfx_drop.play()
		hook.stop_hooking(body,body.global_position,true)
		var timer = get_tree().create_timer(1.25)
		await timer.timeout
		key.visible=true
	elif body is Block:
		if self.name=="KillZone_1":
			hook.stop_hooking(body,body.global_position,true)
			hole=scene.get_node("Holes/Hole_1")
			closed_hole=scene.get_node("Holes/Closed_Hole_1")
			is_hole=true
		elif self.name=="KillZone_2":
			hook.stop_hooking(body,body.global_position,true)
			hole=scene.get_node("Holes/Hole_2")
			closed_hole=scene.get_node("Holes/Closed_Hole_2")
			is_hole=true
		elif self.name=="KillZone_3":
			hook.stop_hooking(body,body.global_position,true)
			hole=scene.get_node("Holes/Hole_3")
			closed_hole=scene.get_node("Holes/Closed_Hole_3")
			is_hole=true
		elif self.name=="KillZone_4":
			hook.stop_hooking(body,body.global_position,true)
			hole=scene.get_node("Holes/Hole_4")
			closed_hole=scene.get_node("Holes/Closed_Hole_4")
			is_hole=true
		elif self.name=="KillZone_11":
			hook.stop_hooking(body,body.global_position,false)
			switch_door=scene.get_node("Switch/Switch_Door_1")
			is_switch=true
		elif self.name=="KillZone_12":
			hook.stop_hooking(body,body.global_position,false)
			switch_door=scene.get_node("Switch/Switch_Door_2")
			is_switch=true
		elif self.name=="KillZone_13":
			hook.stop_hooking(body,body.global_position,false)
			switch_door=scene.get_node("Switch/Switch_Door_3")
			is_switch=true
		if is_hole:
			var timer = get_tree().create_timer(0.25)
			await timer.timeout
			hole.visible=false
			closed_hole.visible=true
			hole.collision_enabled=false
			collisionShape.disabled=true
			check_puzzl_solve()
		elif is_switch:
			sfx_switch.play()
			switch_door.visible=false
			switch_door.collision_enabled=false


func _on_body_exited(body: Node2D) -> void:
	if body is Block: 
		if is_switch:
			switch_door.visible=true
			switch_door.collision_enabled=true

func check_puzzl_solve():
	var res =true
	res= res and scene.get_node("Holes/Closed_Hole_1").visible==true
	res= res and scene.get_node("Holes/Closed_Hole_2").visible==true
	res= res and scene.get_node("Holes/Closed_Hole_3").visible==true
	res= res and scene.get_node("Holes/Closed_Hole_4").visible==true
	if res : 
		print("puzzle résolu")
		$HUD.add_child(dialog_box.instantiate())
		$HUD/DialogBox.print("'Mais ou est mon Steak ?'\nUn garde cherche un steak")
		if worldState: 
			worldState.door2_open=true
		
func _input(event: InputEvent) -> void:
	if self.name=="Level3":
		if event.is_action_released("ui_accept"):
			for child in $HUD.get_children():
				child.queue_free()
