extends Control

var SquareScene := preload("res://Scenes/square.tscn")
var block
var hunger = 100

var maximum = 260

func _ready() -> void:
	var rect = $CanvasLayer/ColorRect
	
	var new_height = (maximum / 100.0) * hunger
	
	rect.size.y = new_height
	rect.position.y = maximum - new_height

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

func update():
	hunger = 100
	var newheight = (260.0 / 100.0) * hunger
	var heightdiff = newheight - $CanvasLayer/ColorRect.size.y

	var tween = create_tween()

	tween.tween_property($CanvasLayer/ColorRect, "size:y", newheight, 0.5)
	tween.parallel().tween_property($CanvasLayer/ColorRect,"position:y",$CanvasLayer/ColorRect.position.y - heightdiff,0.5)
