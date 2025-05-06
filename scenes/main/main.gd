class_name Main
extends Node2D

@onready var game_state_machine: GameStateMachine = $GameStateMachine as GameStateMachine
@onready var level: Node2D = $Level

const CHARACTER_SIZE := Vector2(26, 36)


func _ready() -> void:
	game_state_machine.init()


func _on_level_completed() -> void:
	$LevelSelect.unlock_surrounding_levels()
