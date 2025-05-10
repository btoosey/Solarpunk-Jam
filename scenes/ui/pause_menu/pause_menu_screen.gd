extends CanvasLayer


@onready var game_state_machine: GameStateMachine = $"../GameStateMachine" as GameStateMachine
@onready var resume_button: Button = $Control/PauseMenu/ResumeButton

var paused := false
var pausable := false


func _input(event: InputEvent) -> void:
	if not pausable:
		return

	if event.is_action_pressed("pause_unpause"):
		if paused:
			unpause_game()
		else:
			pause_game()


func unpause_game() -> void:
	get_tree().paused = false
	hide()
	paused = false


func pause_game() -> void:
	get_tree().paused = true
	show()
	paused = true


func _on_resume_button_pressed() -> void:
	unpause_game()


func _on_level_select_button_pressed() -> void:
	unpause_game()
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.LEVEL_SELECT)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
