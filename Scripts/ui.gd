extends Control

var SquareScene := preload("res://Scenes/square.tscn")
var block

func _on_button_pressed() -> void:
	if(!Map.shown):
		var sq = SquareScene.instantiate()
		add_child(sq)
		var rect = sq.get_node("ColorRect")
		rect.size = Vector2(640, 360)
		rect.color = Color.BLACK
		rect.z_index = 0
		block = rect
		Map.disp()
	else:
		block.queue_free()
		Map.hidemap()
