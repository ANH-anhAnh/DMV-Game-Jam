extends Node
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var playing = 0

func _ready() -> void:
	play_music()

func play_music():
	if(!playing):
		playing = 1
		audio_stream_player.play()
