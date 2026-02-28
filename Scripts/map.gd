extends Node2D
class_name Map

var layout1 = [
	[0,0,1,0,0],
	[0,0,0,0,1],
	[0,1,0,0,0],
	[0,1,0,1,0],
	[0,1,0,0,0]
]

var cell_size := 50
var SquareScene := preload("res://Scenes/square.tscn")

func _ready():
	showmap(layout1)

func showmap(layout):
	var ypos = 0
	for row in layout:
		var xpos = 0
		for cell in row:
			if cell == 1:
				var sq = SquareScene.instantiate()
				add_child(sq)
				sq.position = Vector2(xpos, ypos)
			xpos += cell_size
		ypos += cell_size
