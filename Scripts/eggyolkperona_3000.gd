extends Node2D
var SquareScene := preload("res://Scenes/square.tscn")

func _ready() -> void:
	$Sprite2D.visible = true

func _on_button_pressed() -> void:
	Map.syringe = 1
	var sq = SquareScene.instantiate()
	add_child(sq)
	var rect = sq.get_node("ColorRect")
	rect.size = Vector2(640, 360)
	rect.color = Color(1.0, 0.0, 0.0, 0.0)
	$Sprite2D.visible = false
	$Button.disabled = true
	$Textbox.queue_text("Is that you, Pick? I found one of the sacred instruments lying around.","perona","default",0)
	$Textbox.queue_text("Could you give this to the pastor? Who knows what the heavens would do to us without it. Eternal Suffering in hell","perona","default",0)
	$Textbox.queue_text("We just have to follow the pastor.","perona","default",0)
	$Textbox.queue_text("Why dont you bloodydamn fools think for yourselves. Gimme that!","perona","default",1)
	await wait_for_next_event(.1)
	
	$Sprite2D.visible = true

func wait_for_next_event(time : float):
	await get_tree().create_timer(.1, false).timeout
	while ($Textbox.start.text != ""):
		await get_tree().create_timer(.1, false).timeout
	await get_tree().create_timer(time, false).timeout
