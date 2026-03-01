extends RigidBody2D

var offset = Vector2()
var dragging := false
var dragging_allowed = true
var parasite_types = [
	preload("res://Assets/parasite1.png"),
	preload("res://Assets/parasite2.png"),
	preload("res://Assets/parasite3.png"),
	preload("res://Assets/parasite4.png")
]

@onready var parent_node = $"../.."

# pick random texture for each parasite instantiated
func _ready() -> void:
	$parasiteSprite.texture = parasite_types.pick_random()

# dragging parasite functionality
func _process(delta: float) -> void:
	if dragging and dragging_allowed:
		position = (get_global_mouse_position() - offset) / parent_node.scale

# if the item enters the parasite dropoff area, the player wont be able to drag it anymore
func body_entered_checkout() -> void:
	dragging_allowed = false 

# if the parasite is outside the stomach, gravity applies, otherwise, it sticks in stomach	
func parasite_apply_gravity(outsideStomach : bool) -> void:
	if outsideStomach:
		gravity_scale = 0.5
	else:
		gravity_scale = 0
	
func _on_button_button_down() -> void:
	dragging = true
	freeze = true
	offset = get_global_mouse_position() - global_position
	$squish.play()

func _on_button_button_up() -> void:
	freeze = false
	dragging = false
	
# use this to detect that ONLY the parasite body2D class enters the drop off ares
func parasite():
	pass
