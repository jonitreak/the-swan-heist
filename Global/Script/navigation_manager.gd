extends Node

const scene_level1 = preload("res://Scenes/Levels/Level_1_spawn.tscn")
const scene_level2 = preload("res://Scenes/Levels/Level_2_GardeEndormi.tscn")
const scene_level3 = preload("res://Scenes/Levels/Level_3_Mob_Den.tscn")
const scene_level4 = preload("res://Scenes/Levels/Level_4_Armurerie.tscn")

signal on_trigger_player_spawn
var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	match level_tag: 
		"level1": 
			scene_to_load = scene_level1
		"level2": 
			scene_to_load = scene_level2
		"level3":
			scene_to_load=scene_level3
		"level4":
			scene_to_load=scene_level4
			

	if scene_to_load!=null:
		if destination_tag=="0":
			CaughtTransition.transition()
			await CaughtTransition.on_caught_transition_finished
			spawn_door_tag=destination_tag
			get_tree().change_scene_to_packed(scene_to_load)
		else: 
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			spawn_door_tag=destination_tag
			get_tree().change_scene_to_packed(scene_to_load)
		

			
func trigger_player_spawn(position:Vector2, direction:String):
	on_trigger_player_spawn.emit(position,direction)
