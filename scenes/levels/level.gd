extends Node2D


@onready var pause_menu_screen: CanvasLayer = $"../../PauseMenuScreen"
@onready var game_state_machine: GameStateMachine = $"../../GameStateMachine" as GameStateMachine
@onready var characters: Node2D = $Characters
@onready var collectibles: Node2D = $Collectibles

var level_log: Array
var turn_number := 0
var allow_undo := true


func _ready() -> void:
	characters.undo.connect(_on_undo)
	characters.characters_moved.connect(log_level_state)
	collectibles.all_collectibles_collected.connect(_on_level_completed)
	log_level_state()
	if DialogicResourceUtil.get_timeline_resource("%s" % name) != null and not LevelsData.is_in_session:
		Dialogic.signal_event.connect(_on_dialogic_signal)

		start_level_dialogue()
	else:
		allow_movement()


func _on_undo() -> void:
	if not allow_undo:
		return

	if level_log.size() > 1:
		var chara_index := 0
		for chara in characters.get_children():
			chara.position = level_log[-2][chara_index]
			chara_index += 1

		for col in collectibles.get_children():
			if col.turn_collected == level_log.size():
				col.reset_collectible()

		level_log.pop_back()
		turn_number -= 1


func log_level_state() -> void:
	var new_state := []

	for c in characters.get_children():
		new_state.append(c.global_position)

	if level_log.size() == 0 or level_log[-1] != new_state:
		level_log.append(new_state)
		turn_number += 1


func _on_level_completed() -> void:
	pause_menu_screen.pausable = false
	characters.stop_characters_moving()
	$"../../LevelSelect".unlock_surrounding_levels()
	$"../../LevelSelect".set_current_level_as_complete()
	await get_tree().create_timer(2.5).timeout
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.LEVEL_SELECT)


func start_level_dialogue() -> void:
	var layout = Dialogic.Styles.load_style("speech_bubble_style")

	if characters.get_children().size() >= 3:
		layout.register_character(load("res://dialogic_styles_characters/elim.dch"), characters.get_child(2).speech_marker)

	if characters.get_children().size() >= 2:
		layout.register_character(load("res://dialogic_styles_characters/bradley.dch"), characters.get_child(1).speech_marker)

	if characters.get_children().size() >= 1:
		layout.register_character(load("res://dialogic_styles_characters/tikara.dch"), characters.get_child(0).speech_marker)

	Dialogic.start("%s" % name)


func _on_dialogic_signal(arg: String) -> void:
	if arg == "move":
		allow_movement()


func allow_movement() -> void:
	for c in characters.get_children():
		c.grid_mover.can_move = true	
