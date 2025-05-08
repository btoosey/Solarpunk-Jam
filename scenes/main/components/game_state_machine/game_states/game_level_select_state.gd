extends GameState


@onready var level_select: CanvasLayer = $"../../LevelSelect"
@onready var scene_transition: CanvasLayer = $"../../SceneTransition"


func enter() -> void:
	await get_tree().create_timer(1.5).timeout
	scene_transition.fade_out()
	level_select.show()
	level_select.enabled = true


func exit() -> void:
	scene_transition.fade_in()
	await get_tree().create_timer(1).timeout
	level_select.enabled = false
	level_select.hide()
