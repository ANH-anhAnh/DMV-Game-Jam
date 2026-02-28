extends Node2D
var SquareScene := preload("res://Scenes/square.tscn")

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/rooms/room_1.tscn")

func _on_options_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
