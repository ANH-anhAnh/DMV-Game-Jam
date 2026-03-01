extends Node2D

func _on_button_pressed() -> void:
	$Sprite2D.visible = true
	$Textbox.queue_text("Ah. I’ve been expecting you… Almost every year, some bloodsucker gets some big idea. ","default","default",1)
	$Textbox.queue_text("Freedom! Escape! You think maybe there’s some greater purpose out there, don’t ya? Well I’m about to tell ya, YER OUT OF YA GORYDAMN-","default","default",1)
	wait_for_next_event(.1)
	$Sprite2D.visible = false

func wait_for_next_event(time : float):
	await get_tree().create_timer(.1, false).timeout
	while ($Textbox.start.text != ""):
		await get_tree().create_timer(.1, false).timeout
	await get_tree().create_timer(time, false).timeout
