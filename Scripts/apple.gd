extends Node2D

func _ready() -> void:
	if Map.food[Map.selfpos[1]][Map.selfpos[0]] == 0:
			$Button.disabled = true
			$".".visible = false

func _on_button_pressed() -> void:
	$Button.disabled = true
	$".".visible = false
	Map.food[Map.selfpos[1]][Map.selfpos[0]] = 0
	Map.hunger = 100
	Map.stomach_parasites += 5
