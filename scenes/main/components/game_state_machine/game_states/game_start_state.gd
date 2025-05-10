extends GameState


@onready var main_menu: CanvasLayer = $"../../MainMenu"


func exit() -> void:
	main_menu.fade_out()
