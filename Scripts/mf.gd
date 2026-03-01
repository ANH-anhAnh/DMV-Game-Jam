extends Node2D
var SquareScene := preload("res://Scenes/square.tscn")

func _ready() -> void:
	if Map.food[Map.selfpos[1]][Map.selfpos[0]] == 0:
		$Sprite2D.visible = false
		$Button.disabled = true
		

func _on_button_pressed() -> void:
	var sq = SquareScene.instantiate()
	add_child(sq)
	var rect = sq.get_node("ColorRect")
	rect.size = Vector2(640, 360)
	rect.color = Color(1.0, 0.0, 0.0, 0.0)
	Map.food[Map.selfpos[1]][Map.selfpos[0]] = 0
	$Sprite2D.visible = false
	$Button.disabled = true
	$Textbox.queue_text("Ah. I’ve been expecting you… Almost every year, some bloodsucker gets some big idea. ","default","default",1)
	$Textbox.queue_text("Freedom! Escape! You think maybe there’s some greater purpose out there, don’t ya? Well I’m about to tell ya, YER OUT OF YA GORYDAMN-","default","default",1)
	$Textbox.queue_text("... Watch your bloody mouth, old man. I don’t have time for this. Either you help me or get the hell out of my way.","default","default",0)
	$Textbox.queue_text("HA. HAHA. HAHAHAH. You know what… I like you. Take this","default","default",1)
	$Textbox.queue_text("NANOBOT Acquired","default","default",0)
	$Textbox.queue_text("MAP Acquired","default","default",0)
	$Textbox.queue_text("It will keep the parasites at bay. However, you must find the remote for it. Trust me. Or don’t. I can buy you some time.","default","default",1)
	$Textbox.queue_text("*The mysterious figure leaves*","default","default",0)
	$Textbox.queue_text(" What a bloodydamn psycho…","default","default",0)
	await wait_for_next_event(.1)
	
	Map.mapaccess = 1
	Map.mf = 1
	get_node("../UI/CanvasLayer/Button").disabled = false
	get_node("../UI/CanvasLayer/Button").visible = true

func wait_for_next_event(time : float):
	await get_tree().create_timer(.1, false).timeout
	while ($Textbox.start.text != ""):
		await get_tree().create_timer(.1, false).timeout
	await get_tree().create_timer(time, false).timeout
