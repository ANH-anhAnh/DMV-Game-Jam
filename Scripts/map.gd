extends Node2D

var layout1 = [
	[0,1,0,0,0],
	[1,1,1,1,0],
	[1,0,0,1,0],
	[1,"res://Scenes/rooms/room_2.tscn",1,1,0],
	[0,"res://Scenes/rooms/room_1.tscn",0,0,0]
]

var currentlayout

var selfpos = [1,4]

var cell_size := 50
var SquareScene := preload("res://Scenes/square.tscn")
var CircleScene := preload("res://Scenes/circle.tscn")

func _ready():
	pass
	
func showmap(layout):
	var ypos = 0
	var yp = 0
	for row in layout:
		var xpos = 0
		var xp = 0
		for cell in row:
			if cell is String:
				var sq = SquareScene.instantiate()
				add_child(sq)
				sq.position = Vector2(xpos, ypos)
			elif cell == 1:
				var sq = SquareScene.instantiate()
				add_child(sq)
				sq.position = Vector2(xpos, ypos)
			if xp == selfpos[0] and yp == selfpos[1]:
				var cir = CircleScene.instantiate()
				add_child(cir)
				cir.position = Vector2(xpos + 20, ypos + 20) 
			xpos += cell_size
			xp += 1
		ypos += cell_size
		yp += 1
		
func sceneupdate(change):
	selfpos[0] += change[0]
	selfpos[1] += change[1]
	get_tree().change_scene_to_file(layout1[selfpos[1]][selfpos[0]])
