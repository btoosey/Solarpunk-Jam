extends Node

@onready var game_state_machine: GameStateMachine = $"../GameStateMachine" as GameStateMachine
@onready var level: Node2D = $"../Level"

var level_scene


func instantiate_level() -> void:
	var level_instance = level_scene.instantiate()
	level.add_child(level_instance)

	level.get_child(0).characters.connect_hazards_to_reloader()
	level.get_child(0).characters.reload_level.connect(_on_reload_level)


func _on_level_select_level_selected(path: Variant) -> void:
	level_scene = load(path) as PackedScene
	instantiate_level()
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.PLAY)
	LevelsData.is_in_session = true


func reload_level() -> void:
	clear_current_level()
	instantiate_level()


func _on_reload_level() -> void:
	reload_level()


func clear_current_level() -> void:
	if level.get_child_count() > 0:
		var lv = level.get_child(0)
		level.remove_child(lv)
		lv.queue_free()
