extends Node

const scene_level1= preload("res://Scenes/Levels/Level_1_spawn.tscn")
const scene_level2= preload("res://Scenes/Levels/Level_2_GardeEndormi.tscn")

signal on_trigger_player_spawn
var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	print("ok",level_tag," ",destination_tag)
	var scene_to_load
	match level_tag: 
		"level1": 
			scene_to_load = scene_level1
		"level2": 
			scene_to_load = scene_level2

	if scene_to_load!=null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag=destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
		

			
func trigger_player_spawn(position:Vector2, direction:String):
	on_trigger_player_spawn.emit(position,direction)
