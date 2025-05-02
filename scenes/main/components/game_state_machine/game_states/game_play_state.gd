extends GameState


@onready var level_loader_reloader: Node = $"../../LevelLoaderReloader"


func exit() -> void:
	level_loader_reloader.clear_current_level()
