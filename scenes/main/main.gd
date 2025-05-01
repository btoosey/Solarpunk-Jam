extends Node2D

@onready var game_state_machine: GameStateMachine = $GameStateMachine as GameStateMachine
@onready var level: Node2D = $Level


func _ready() -> void:
	game_state_machine.init()


func _on_level_loader_reloader_level_loaded() -> void:
	level.get_child(0).characters.connect_hazards_to_reloader()
