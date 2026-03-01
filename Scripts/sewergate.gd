extends Node2D

@onready var textbox = $Textbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Map.gate == 0:
		textbox.queue_text("It’s obstacle after obstacle in this damn maze, ain’t it? If I hadn’t been raised in this hellhole, maybe I’d have the strength to break through…", "default", "default", 1)
		textbox.queue_text("...", "default", "default", 1)
		textbox.queue_text("... wait a minute.", "default", "default", 1)
		textbox.queue_text("clanging sound effects", "default", "default", 1)
		textbox.queue_text("There’s a contraption. If I could break this. If I could open this somehow…", "default", "default", 1)
		textbox.queue_text("Whatever it is, that bloodydamn psycho holds the answers. I’ll beat him to a bloody pulp ‘till he gives it up.", "default", "default", 1)
		Map.gate = 1
