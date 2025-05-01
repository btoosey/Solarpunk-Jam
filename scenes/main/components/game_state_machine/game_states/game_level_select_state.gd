extends GameState


@onready var level_select: Control = $"../../LevelSelect"


func enter() -> void:
	level_select.show()
	level_select.enabled = true


func exit() -> void:
	level_select.enabled = false
	level_select.hide()
