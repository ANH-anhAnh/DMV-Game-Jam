extends Node2D

# number of parasites currently in stomach
# -> controls the decay rate of hunger
var stomach_parasites : int
# number of parasites collected
var collected_parasites : int

## level layout, contains all room scenes 
var layout1 = [
	[0,1,0,0,0],
	[1,1,1,1,0],
	[1,0,0,"res://Scenes/rooms/upright.tscn","res://Scenes/rooms/remotesewerroom.tscn"],
	["res://Scenes/rooms/sewerroom.tscn","res://Scenes/rooms/room_2.tscn","res://Scenes/rooms/longchasmpipe.tscn","res://Scenes/rooms/bendrighttoup.tscn",0],
	[0,"res://Scenes/rooms/room_1.tscn",0,0,0]
]

var food = [
	[0,0,0,0,0],
	[0,0,0,0,0],
	[0,0,0,0,0],
	[1,1,0,0,0],
	[0,0,0,0,0]
]
##array containing explored coordinates
var explored = []

var playercircle
var currentlayout

var selfpos = [1,3]
var shown = 0
var mapaccess = 0
var cell_size := 50
var SquareScene := preload("res://Scenes/square.tscn")
var CircleScene := preload("res://Scenes/circle.tscn")
#resets the explored coordinates on enter
func _ready():
	currentlayout = layout1
	reset()

func disp():
	showmap(explored)

##just sets explored size to level size then zeroes every entry
func reset():
	explored = []
	for row in currentlayout:
		explored.append(row.duplicate())

	for y in range(explored.size()):
		for x in range(explored[y].size()):
			explored[y][x] = 0

	explored[selfpos[1]][selfpos[0]] = 1

## goes through every explored panel and displays explored spaces
func showmap(layout):
	self.show()
	var ypos = 100
	var yp = 0
	for row in layout:
		var xpos = 250
		var xp = 0
		for cell in row:
			if cell is String:
				var sq = SquareScene.instantiate()
				add_child(sq)
				sq.position = Vector2(xpos, ypos)
				sq.z_index = 2
			elif cell == 1:
				var sq = SquareScene.instantiate()
				add_child(sq)
				sq.position = Vector2(xpos, ypos)
				sq.z_index = 2
			if xp == selfpos[0] and yp == selfpos[1]:
				var cir = CircleScene.instantiate()
				add_child(cir)
				cir.position = Vector2(xpos + 20, ypos + 20) 
				cir.z_index = 2
				playercircle = cir
			xpos += cell_size
			xp += 1
		ypos += cell_size
		yp += 1
	shown = 1
	while shown:
		##blinking player circle :
		await get_tree().create_timer(.5).timeout
		playercircle.visible = false
		await get_tree().create_timer(.5).timeout
		playercircle.visible = true


func hidemap():
	shown = 0
	self.hide()

##updates explored spaces and changes scenes!
func sceneupdate(change):
	selfpos[0] += change[0]
	selfpos[1] += change[1]
	Transition.transition()
	await Transition.on_transition_finished
	explored[selfpos[1]][selfpos[0]] = 1
	get_tree().change_scene_to_file(layout1[selfpos[1]][selfpos[0]])
