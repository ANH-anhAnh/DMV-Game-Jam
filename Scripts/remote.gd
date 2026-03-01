extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Map.parasiteaccess == 1:
		$Button.disabled = true
		$Sprite2D.visible = false


func _on_button_pressed() -> void:
	if Map.mf == 1:
		Map.parasiteaccess = 1
		$Sprite2D.visible = false
		$Button.disabled = true
		get_node("../UI/CanvasLayer/Button2").disabled = false
		get_node("../UI/CanvasLayer/Button2").visible = true
	else:
		$Textbox.queue_text("A remote? I have no use for this.","default","default",0)
