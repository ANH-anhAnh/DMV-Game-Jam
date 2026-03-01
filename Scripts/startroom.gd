extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Map.lethal and (Map.syringe):
		$Textbox.queue_text("Ah. I suppose you’ve had a change of heart? Realized there’s nothing beyond those gates? We survivors are safe under here. Drought follows the burning sun. Nothing that touches it survives.","default","pastor",1)
		$Textbox.queue_text("Burning sun? You mean to tell me there’s something up there? BEYOND THOSE BLOODY GATES YOU LOCKED US BEHIND?","default","pastor",0)
		$Textbox.queue_text("*You lunge forward with all your might. Digging the syringe into the pastor’s skin, you press your thumb against the plunger.*","default","pastor",0)
		$Textbox.queue_text("GAAAH. WHAT HAVE YOU DONE?","default","pastor",1)
		$Textbox.queue_text("*His hands are wildly flailing around. He stumbles towards you sporadically.","default","pastor",0)
		$Textbox.queue_text("H-Huuurrkk","default","pastor",1)
		$Textbox.queue_text("*The pastor slumps to the floor.*","default","default",0)
		$Textbox.queue_text("*You rummage through his pockets*","default","default",0)
		$Textbox.queue_text("I’ll be taking that. Thank yeww~ :3","default","default",0)
		$Textbox.queue_text("*KEY ACQUIRED*","default","default",0)

	else:
		$Textbox.queue_text("Ah. I suppose you’ve had a change of heart? Realized there’s nothing beyond those gates? We survivors are safe under here. Drought follows the burning sun. Nothing that touches it survives.","default","pastor",1)
		$Textbox.queue_text("Burning sun? You mean to tell me there’s something up there? BEYOND THOSE BLOODY GATES YOU LOCKED US BEHIND?","default","pastor",0)
		$Textbox.queue_text("Haha. hah. Unless you’ve somehow found a way to kill me, you’ll never see the sun anyway.","default","pastor",1)
		$Textbox.queue_text("Dami. Shut this psycho up for good.","default","pastor",1)
		$Textbox.queue_text("*A sharp pain strikes the back of your head.*","default","pastor",0)
		$Textbox.queue_text("A thick, warm liquid trickles down, filling your vision. Why is it so cold? Why? Why won’t anyone help me? Why won’t anyone? Save me? Believe me?","default","pastor",0)
		$Textbox.queue_text("“Mom?” *You manage to croak out, before you slump to the floor","default","pastor",0)
		get_tree("res://Scenes/GameOver.tscn").change_scene_to_file()
		
		
