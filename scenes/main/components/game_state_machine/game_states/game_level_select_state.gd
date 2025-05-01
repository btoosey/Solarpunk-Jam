extends GameState


@onready var level_select: Control = $"../../LevelSelect"


func enter() -> void:
	level_select.show()


func exit() -> void:
	level_select.hide()
