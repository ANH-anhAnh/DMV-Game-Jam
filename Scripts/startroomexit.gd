extends Control


func _on_button_pressed() -> void:
	if(Map.gate == 0):
		$Textbox.queue_text("Im not going back in there as I am now.","default","default",1)
	else:
		var change = [0,1]
		Map.sceneupdate(change)
