extends Node2D
## this circle scene just draws a circle for map
@export var radius := 10
@export var color := Color.DARK_RED
##draws a circle for this scene. 
func _draw():
	draw_circle(Vector2.ZERO, radius, color)
