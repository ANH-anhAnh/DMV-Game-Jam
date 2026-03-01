extends Node2D

@onready var textbox := $Textbox
@onready var pastor_speech_text : RichTextLabel = $PastorSpeech/PersonalText
@onready var pastor_sprite := $PastorSpeech/PastorSpeaking
@onready var text_timer := $TextTimer 

func _ready() -> void:
	textbox.queue_text(
		"Your time has come. Everyone who reaches of age goes through the same ritual.",
		"default","pastor", 1
		)
	textbox.queue_text("Become one. Embrace the Body.", "default", "default", 1)
	
	textbox.queue_text(
		"Hah! You're out of your goddamn mind. There’s something out there, I tell ya! SOMETHING GREATER THAN THIS HOLED UP STINKHOLE. EVERYONE OUT THERE-",
		"default", "pastor", 0
	)
	textbox.queue_text(
		"*You feel a sharp pain at the back of your head. Your vision slowly fades.", 
		"default", "default", 0
	)
	
	# vision fades __-------------------------------------------------------------------------------
	await wait_for_next_event(0.1)
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 1), 1)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)\
	.from(Color(1, 1, 1, 0))
	
	textbox.queue_text(
		"This one’s always been a pain in the arse, I tell ya. Inject him and get it over with.",
		"default", "pastor_annoyed", 1
	)
	# pastor appears -------------------------------------------------------------------------------
	await wait_for_next_event(0.1)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(pastor_sprite, "modulate", Color(1, 1, 1, 1), 1)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)\
	.from(Color(1, 1, 1, 0))

	# pastor speech --------------------------------------------------------------------------------
	# TODO: animate this
	#pastor_speech_text.text = "Hah. Pick’s always been a rowdy one. Big ideas. Big dreams..."
	#pastor_speech_text.text = "But now, is the era of Darkness. We need unity to survive. 
		#So I beg you, children. Serve the Body faithfully, and it will serve you back."
	#pastor_speech_text.text = "For your fathers, lovers, mothers. For me. For you."
	
	# ----------------------------------------------------------------------------------------------
	# wait X amount of seconds after pastor is annoyed. makes room for pastor's speech	
	await wait_for_next_event(4)
	
	textbox.queue_text("Easy now. Don’t resist.", "default", "default", 0)
	
	textbox.queue_text("*You feel a pinching sensation in your arm.", "default", "default", 0)
	textbox.queue_text("Suddenly, you jolt up and push past the pastor, running towards the exit.", "default", "default", 0)
	
# --------------------------------------------------------------------------------------------------
func wait_for_next_event(time : float):
	await get_tree().create_timer(.1, false).timeout
	while (textbox.start.text != ""):
		await get_tree().create_timer(.1, false).timeout
	await get_tree().create_timer(time, false).timeout
