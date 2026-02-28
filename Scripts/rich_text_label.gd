extends RichTextLabel

var speed = 0.05
var timer = 0.0
var last_visible_characters = 0

func _process(delta):
	if visible_ratio < 1:
		timer += delta
		if timer >= speed:
			visible_ratio += 0.01
			if visible_characters > last_visible_characters:
				# $SoundEffect.play()
				last_visible_characters = visible_characters
			timer = 0.0
