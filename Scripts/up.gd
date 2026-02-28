extends Control



##room object changes locations.
func _on_button_pressed() -> void:
	var change = [0,-1]
	Map.sceneupdate(change)
