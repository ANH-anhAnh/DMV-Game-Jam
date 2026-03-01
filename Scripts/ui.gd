extends Control

var SquareScene := preload("res://Scenes/square.tscn")
var block
var hunger = 100
var maximum = 100
## sets hunger bar
func _ready() -> void:
	var mapaccess = Map.mapaccess
	if mapaccess:
		$CanvasLayer/Button.disabled = false
		$CanvasLayer/Button.visible = true
	else:
		$CanvasLayer/Button.disabled = true
		$CanvasLayer/Button.visible = false
	
	var newheight = (260.0 / 100.0) * hunger
	var heightdiff = newheight - $CanvasLayer/ColorRect.size.y

	$CanvasLayer/ColorRect.size.y = newheight
	$CanvasLayer/ColorRect.position.y = $CanvasLayer/ColorRect.position.y - heightdiff
##map button
func _on_button_pressed() -> void:
	if(!Map.shown):
		var sq = SquareScene.instantiate()
		add_child(sq)
		var rect = sq.get_node("ColorRect")
		rect.size = Vector2(640, 360)
		rect.color = Color.BLACK
		block = rect
		$CanvasLayer/left.visible = false
		$CanvasLayer/right.visible = false
		
		Map.disp()
	else:
		block.queue_free()
		$CanvasLayer/left.visible = true
		$CanvasLayer/right.visible = true
		Map.hidemap()
		
## updates the hunger bar
func update():
	var newheight = (260.0 / 100.0) * hunger
	var heightdiff = newheight - $CanvasLayer/ColorRect.size.y

	var tween = create_tween()

	tween.tween_property($CanvasLayer/ColorRect, "size:y", newheight, 0.5)
	tween.parallel().tween_property($CanvasLayer/ColorRect,"position:y",$CanvasLayer/ColorRect.position.y - heightdiff,0.5)
