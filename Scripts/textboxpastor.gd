extends CanvasLayer

#this signal tells player scene to stop accepting inputs when textbox is up.
signal still
@onready var textbox_container: MarginContainer = $TextboxContainer
@onready var label: Label = $TextboxContainer/MarginContainer/HBoxContainer/Label
@onready var tween = get_tree().create_tween()

var reading = 0
#adjusts rate at which textbox reads
const char_read_rate = 0.03
#state for state machine
var current_state = State.READY
# stores all inputted text to display one at a time
var text_queue = []
#varibale to keep track of which character is speaking
var front = -1

#enum for state machine
enum State{
	READY,
	READING,
	FINISHED
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	hide_box()
	$right.play("default")
	$left.play("default")
	
#sets textbox for when box is hidden
func hide_box():
	label.text = ""
	textbox_container.hide()
	$right.play("default")
	$left.play("default")

# adds the next entry into an array. 
# The textbox will stay open until array is empty
# parameters are text as a string, left and right sprites names as a string,
# and who is speaking as an integer 0,1
func queue_text(next_text,left,right,who):
	text_queue.push_back([next_text,left,right,who])


# makes box visible
func show_box():
	textbox_container.show()
	
# changes the textbox text and manages sprites per queue entry
func display_text():
	#two tweens, one for sprites one for text box
	tween = get_tree().create_tween()
	var anim = get_tree().create_tween()
	var next_text = text_queue.pop_front()

	#index 0 contains text to display
	label.text = next_text[0]
	label.visible_characters = -1
	#reading state allows text to be skipped
	change_state(State.READING)
	show_box()
	#index 1 and 2 contain left and right sprite names respectivelt
	$right.play(next_text[2])
	$left.play(next_text[1])
	# tweens into foreground and background depending on who is speaking index 3 contains who
	if(next_text[3] and front != next_text[3]):
		anim.tween_property($right, "modulate:a", 1, .5).from($right.modulate.a)
		anim.parallel().tween_property($left, "modulate:a", .5, .5).from($left.modulate.a)
		front = 1
	elif(front != next_text[3]):
		anim.tween_property($right, "modulate:a", .5, .5).from($right.modulate.a)
		anim.parallel().tween_property($left, "modulate:a", 1, .5).from($left.modulate.a)
		front = 0
	#tweening text to display
	tween.tween_property(label, "visible_characters", len(label.text), len(label.text) * char_read_rate).from(0).finished
	tween.connect("finished", on_tween_finished)
#gets textbo ready for next text
func on_tween_finished():
	change_state(State.FINISHED)
	
	#contains state machine for textbox
func _process(delta: float) -> void:
	match current_state:
		#gets text if there queue isnt empty and freezes screen
		State.READY:
			if !text_queue.is_empty():
				reading = 1
				display_text()
				still.emit()
				
			#contains functionality to skip tweening and show full text.
		State.READING:
			pass
			#checks if queue is empty to close textbox. if not, goes back to ready
		State.FINISHED:
			if(!changing):
				changetoready()
			if text_queue.is_empty():
				hide_box()
				reading = 0

var changing = 0
func changetoready():
	changing = 1
	await get_tree().create_timer(1, false).timeout
	change_state(State.READY)
	changing = 0

#change state function
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			pass
			
