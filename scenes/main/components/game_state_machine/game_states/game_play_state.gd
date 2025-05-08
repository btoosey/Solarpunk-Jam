extends GameState


@onready var level_loader_reloader: Node = $"../../LevelLoaderReloader"
@onready var pause_menu_screen: CanvasLayer = $"../../PauseMenuScreen"
@onready var scene_transition: CanvasLayer = $"../../SceneTransition"


func enter() -> void:
	await get_tree().create_timer(1.7).timeout
	scene_transition.fade_out()
	pause_menu_screen.pausable = true


func exit() -> void:
	scene_transition.fade_in()
	await get_tree().create_timer(1).timeout
	level_loader_reloader.clear_current_level()
	pause_menu_screen.pausable = false
