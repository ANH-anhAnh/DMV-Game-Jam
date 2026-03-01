extends Control

var SquareScene := preload("res://Scenes/square.tscn")
var block
var hunger = Map.hunger
var maximum = 100
var parasite = 0
## sets hunger bar
func _ready() -> void:
	var mapaccess = Map.mapaccess
	$"CanvasLayer/parasite screen".visible = false
	if mapaccess:
		$CanvasLayer/Button.disabled = false
		$CanvasLayer/Button.visible = true
	else:
		$CanvasLayer/Button.disabled = true
		$CanvasLayer/Button.visible = false
	if Map.parasiteaccess:
		$CanvasLayer/Button2.disabled = false
		$CanvasLayer/Button2.visible = true
	else:
		$CanvasLayer/Button2.disabled = true
		$CanvasLayer/Button2.visible = false
	
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
		$CanvasLayer/Button2.disabled = true
		Map.disp()
	else:
		block.queue_free()
		$CanvasLayer/left.visible = true
		$CanvasLayer/right.visible = true
		$CanvasLayer/Button2.disabled = false
		Map.hidemap()
		
## parasite scanner button
func _on_button_2_pressed() -> void:
	if(!parasite):
		parasite = 1
		var sq = SquareScene.instantiate()
		add_child(sq)
		var rect = sq.get_node("ColorRect")
		rect.size = Vector2(640, 360)
		rect.color = Color(1.0, 0.0, 0.0, 0.0)
		block = rect
		$"CanvasLayer/parasite screen".visible = true
		$CanvasLayer/Button.disabled = true
	else:
		parasite = 0
		block.queue_free()
		$"CanvasLayer/parasite screen".visible = false
		$CanvasLayer/Button.disabled = false
		
## updates the hunger bar
func update():
	Map.hunger = Map.hunger - (Map.stomach_parasites)
	if(Map.hunger <= 0):
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
	var newheight = (260.0 / 100.0) * Map.hunger
	var heightdiff = newheight - $CanvasLayer/ColorRect.size.y

	var tween = create_tween()

	tween.tween_property($CanvasLayer/ColorRect, "size:y", newheight, 0.5)
	tween.parallel().tween_property($CanvasLayer/ColorRect,"position:y",$CanvasLayer/ColorRect.position.y - heightdiff,0.5)
	if is_instance_valid(self) and is_inside_tree():
		await get_tree().create_timer(5, false).timeout
	hungry = 0

var hungry = 0
func _process(delta: float) -> void:
	if(!hungry):
		hungry = 1
		update()
	
