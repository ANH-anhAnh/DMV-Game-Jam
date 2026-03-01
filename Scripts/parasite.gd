extends RigidBody2D

var offset = Vector2()
var dragging := false
var dragging_allowed = true

@onready var parent_node = $"../.."

# dragging parasite functionality
func _process(delta: float) -> void:
	if dragging and dragging_allowed:
		position = (get_global_mouse_position() - offset) / parent_node.scale

# if the item enters the parasite dropoff area, the player wont be able to drag it anymore
func body_entered_checkout() -> void:
	dragging_allowed = false 

# if the parasite is outside the stomach, gravity applies, otherwise, it sticks in stomach	
func parasite_gravity(inStomach : bool) -> void:
	if (inStomach):
		gravity_scale = 0
	else:
		gravity_scale = 0.5
	
func _on_button_button_down() -> void:
	dragging = true
	freeze = true
	offset = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	freeze = false
	dragging = false
	
# use this to detect that ONLY the parasite body2D class enters the drop off ares
func parasite():
	pass
