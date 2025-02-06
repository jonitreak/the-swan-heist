extends Node

var audio_player: AudioStreamPlayer



func _ready():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)  
	audio_player.bus = "Master"  

func play_sound(stream: AudioStream) -> void:
	if audio_player:
		audio_player.stream = stream
		audio_player.play()
	else:
		print("Erreur : audio_player est toujours null")

	
