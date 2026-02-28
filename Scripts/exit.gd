extends Control
#object for rooms to be able to click to change locations

func _on_button_pressed() -> void:
	var change = [0,1]
	Map.sceneupdate(change)
