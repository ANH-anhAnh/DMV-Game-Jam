extends Control


func _on_button_pressed() -> void:
	var change = [-1,0]
	Map.sceneupdate(change)
