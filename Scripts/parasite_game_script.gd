extends Node2D

# array of points in the stomach_area
@onready var stomach_polygon := $"../Collisions/StomachArea/CollisionPolygon2D"
@onready var stomach_area := $"../Collisions/StomachArea"
# load parasite scene
@onready var parasite_scene := preload("res://Scenes/parasite.tscn") 
var spawning = 0

func _ready() -> void:
	$"../Label".text = str(Map.collected_parasites)
	for i in range(Map.stomach_parasites + 1):
		spawn_parasite()

func _process(_delta):		
	# spawn parasites every 5-10 seconds based on fibonnaci sequence
	if (spawning == 0):
		spawning = 1
		var fiveToTen = randi_range(10, 20)
		await get_tree().create_timer(fiveToTen).timeout
		for i in range(Map.pp_stomach_parasites + Map.pp_stomach_parasites + 1):
			Map.pp_stomach_parasites = Map.p_stomach_parasites
			Map.p_stomach_parasites = Map.stomach_parasites
			spawn_parasite()
		spawning = 0
	
# for spawning parasites inside the stomach area ---------------------------------------------------
func spawn_parasite():
	var parasite_instance = parasite_scene.instantiate()
	$"../Parasites".add_child(parasite_instance)
	
	var local_spawn: Vector2 = Triangle.get_random_point_in_polygon(stomach_polygon.polygon)
	# convert local spawn location to global location
	var global_spawn: Vector2 = stomach_polygon.to_global(local_spawn)
	
	parasite_instance.set_position(to_local(global_spawn))

	
# Triangle class: hangles math for random point generation
# -> triangulate a polygon, pick a triangle, pick a random point in the triangle
class Triangle:
	var _p1: Vector2
	var _p2: Vector2
	var _p3: Vector2
	
	func _init(p1: Vector2, p2: Vector2, p3: Vector2) -> void:
		_p1 = p1
		_p2 = p2
		_p3 = p3
	
	func get_triangle_area() -> float:
		return 0.5 * abs((_p1.x*(_p2.y - _p3.y)) + (_p2.x*(_p3.y - _p1.y)) + (_p3.x*(_p1.y - _p2.y)))
	
	# picks a uniform random point inside a triangle
	func get_random_point():
		var a = randf()
		var b = randf()
		if a > b:
			var c = b
			b = a
			a = c

		return _p1 * a + _p2 * (b - a) + _p3 * (1 - b)
		
	# triangulates the polygon, then picks a random triangle and a random point in it
	static func get_random_point_in_polygon(polygon: PackedVector2Array) -> Vector2:
		return get_random_point_in_triangulated_polygon(polygon, Geometry2D.triangulate_polygon(polygon))
	
	static func get_random_point_in_triangulated_polygon(polygon: PackedVector2Array, triangle_points : PackedInt32Array) -> Vector2:
		var triangle_weights : PackedFloat32Array = []
		var triangles : Array[Triangle] = []
		
		var index = 0
		var polygon_size = triangle_points.size()
		while index < polygon_size:
			var triangle = Triangle.new(polygon[triangle_points[index]], polygon[triangle_points[index + 1]], polygon[triangle_points[index + 2]])
			triangles.append(triangle)
			triangle_weights.append(triangle.get_triangle_area())
			index += 3
		
		return triangles[RandomNumberGenerator.new().rand_weighted(triangle_weights)].get_random_point()
	
# Area signals -------------------------------------------------------------------------------------
func _on_stomach_area_body_exited(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.parasite_apply_gravity(true)
		Map.stomach_parasites -= 1
	
func _on_stomach_area_body_entered(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.parasite_apply_gravity(false)
		Map.stomach_parasites += 1
	
func _on_checkout_area_body_entered(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.body_entered_checkout()
		Map.collected_parasites += 1
		$"../Label".text = str(Map.collected_parasites)
		if(Map.collected_parasites == 20):
			enough()
			
func enough():
	Map.lethal = 1
	$"../Textbox".queue_text("Bloody hell. This amount of parasites could take down even the strongest survivors", "default","default", 1)

func _on_deletion_zone_body_entered(body: Node2D) -> void:
	if body.has_method("parasite"):
		body.queue_free()
