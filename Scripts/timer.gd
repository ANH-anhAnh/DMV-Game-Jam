extends Node

signal spawn

var ticking = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!ticking):
		ticking = 1
		var fiveToTen = randi_range(10, 20)
		await get_tree().create_timer(fiveToTen, false).timeout
		if is_instance_valid($".") and is_inside_tree():
			spawn.emit()
		ticking = 0
