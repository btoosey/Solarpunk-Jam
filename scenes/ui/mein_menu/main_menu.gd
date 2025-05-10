extends CanvasLayer


@onready var game_state_machine: GameStateMachine = $"../GameStateMachine"
@onready var background: TextureRect = $Background

var menu_enabled = true


func fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(background, "modulate", Color.html("00000000"), 1)
	$Label.hide()


func _input(event: InputEvent) -> void:
	if not menu_enabled:
		return

	if event.is_action_pressed("start_game"):
		menu_enabled = false
		game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.LEVEL_SELECT)
