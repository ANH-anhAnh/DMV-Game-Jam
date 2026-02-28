extends Node2D

@export var radius := 10
@export var color := Color.DARK_RED

func _draw():
	draw_circle(Vector2.ZERO, radius, color)
