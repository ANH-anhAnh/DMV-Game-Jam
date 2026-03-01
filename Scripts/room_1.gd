extends Node2D

@onready var textbox := $Textbox
@onready var textboxpastor := $TextboxPastor
#@onready var pastor_speech_text : RichTextLabel = $PastorSpeech/PersonalText
@onready var pastor_sprite := $PastorSpeech/PastorSpeaking
@onready var text_timer := $TextTimer 


func _ready() -> void:
	print(self)
	print(get_parent())
	print(get_children())
	textbox.queue_text(
		"Your time has come. Everyone who reaches of age goes through the same ritual.",
		"default","pastor", 1
		)
	textbox.queue_text("Become one. Embrace the Body.", "default", "pastor", 1)
	
	textbox.queue_text(
		"Hah! You're out of your goddamn mind. There’s something out there, I tell ya! SOMETHING GREATER THAN THIS HOLED UP STINKHOLE. EVERYONE OUT THERE-",
		"default", "pastor", 0
	)
	textbox.queue_text(
		"*You feel a sharp pain at the back of your head. Your vision slowly fades.", 
		"default", "pastor", 0
	)
	
	# vision fades __-------------------------------------------------------------------------------
	await wait_for_next_event(0.1)
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 1), 2.5)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)\
	.from(Color(1, 1, 1, 0))
	
	tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 0.6), 3)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)\
	.from(Color(1, 1, 1, 1))
	
	textbox.queue_text(
		"This one’s always been a pain in the arse, I tell ya. Inject him and get it over with.",
		"default", "pastor_annoyed", 1
	)
	# pastor appears -------------------------------------------------------------------------------
	$whoosh.play()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(pastor_sprite, "modulate", Color(1, 1, 1, 1), 1)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)\
	.from(Color(1, 1, 1, 0))
	await wait_for_next_event(0.1)
	# pastor speech --------------------------------------------------------------------------------
	textboxpastor.queue_text("Hah. Pick’s always been a rowdy one. Big ideas. Big dreams...", "default","default", 1)
	textboxpastor.queue_text("But now, is the era of Darkness. We need unity to survive.", "default","default", 1)
	textboxpastor.queue_text("So I beg you, children. Serve the Body faithfully, and it will serve you back.", "default","default", 1)
	textboxpastor.queue_text("For your fathers, lovers, mothers. For me. For you.", "default","default", 1)
	textboxpastor.queue_text(" ", "default","default", 1)
	# injection animation --------------------------------------------------------------------------
	# wait X amount of seconds after pastor is annoyed. makes room for pastor's speech	
	await wait_for_next_event(2)
	var tween4 = get_tree().create_tween()
	tween4.tween_property($ColorRect, "modulate", Color(1, 1, 1, 1), 1)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)\
	.from(Color(1, 1, 1, 0.7))
	
	textbox.queue_text("Easy now. Don’t resist.", "default", "default", 0)
	textbox.queue_text("*You feel a pinching sensation in your arm.", "default", "default", 0)
	
	await wait_for_next_event(0.1)
	$InjectionAnim.get_child(0).play("injection")
	await wait_for_next_event(1.8)

	textbox.queue_text("The pains jolts you awake. You push past the pastor towards the exit.", "default", "default", 0)
	
	await wait_for_next_event(0.1)
	$PastorSpeech/PastorSpeaking.visible = false
	var tween3 = get_tree().create_tween()
	tween3.tween_property($ColorRect, "modulate", Color(1, 1, 1, 0), 0.5)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)\
	.from(Color(1, 1, 1, 1))
	
	await wait_for_next_event(0.1)
	$BG.play("running")
# --------------------------------------------------------------------------------------------------
func wait_for_next_event(time : float):
	await get_tree().create_timer(.1, false).timeout
	while (textbox.start.text != ""):
		await get_tree().create_timer(.1, false).timeout
	while !textboxpastor.text_queue.is_empty():
		await get_tree().create_timer(.1, false).timeout
	await get_tree().create_timer(time, false).timeout
	


func _on_bg_animation_finished() -> void:
	var change = [0,-1]
	Map.sceneupdate(change)
