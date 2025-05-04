extends GameState


@onready var level_loader_reloader: Node = $"../../LevelLoaderReloader"
@onready var pause_menu_screen: CanvasLayer = $"../../PauseMenuScreen"


func enter() -> void:
	pause_menu_screen.pausable = true


func exit() -> void:
	level_loader_reloader.clear_current_level()
	pause_menu_screen.pausable = false
