extends Node2D

@export var point_1 := Vector2(0,0)
@export var point_2 := Vector2(100,100)

# load parasite scene
@onready var parasite_scene := preload("res://Scenes/parasite.tscn") 

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		spawn_parasite()

func spawn_parasite():
	var parasite_instance = parasite_scene.instantiate()
	add_child(parasite_instance)
	
	var spawn_location: Vector2 = get_random_point_inside(point_1, point_2)
	parasite_instance.set_position(spawn_location)
	
func get_random_point_inside(p1: Vector2, p2: Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x, p2.x)
	var y_value: float = randf_range(p1.y, p2.y)
	
	return Vector2(x_value, y_value)

func _on_stomach_area_body_exited(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.parasite_gravity(false)
	
func _on_stomach_area_body_entered(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.parasite_gravity(true)
	
func _on_checkout_area_body_entered(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.body_entered_checkout()

func _on_deletion_zone_body_entered(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.queue_free()
