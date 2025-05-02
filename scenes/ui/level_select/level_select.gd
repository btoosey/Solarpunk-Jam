extends Control


signal level_selected(path)

@onready var current_level: LevelIcon = $LevelIcon1

var enabled := false


func _ready() -> void:
	update_level_icon_highlighter_position()


func _input(event: InputEvent) -> void:
	if not enabled:
		return

	if event.is_action_pressed("ui_up") and current_level.next_level_up:
		if LevelsData.level_unlocked_status[current_level.next_level_up.level_name]:
			current_level = current_level.next_level_up
			update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_down") and current_level.next_level_down:
		if LevelsData.level_unlocked_status[current_level.next_level_down.level_name]:
			current_level = current_level.next_level_down
			update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_left") and current_level.next_level_left:
		if LevelsData.level_unlocked_status[current_level.next_level_left.level_name]:
			current_level = current_level.next_level_left
			update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_right") and current_level.next_level_right:
		if LevelsData.level_unlocked_status[current_level.next_level_right.level_name]:
			current_level = current_level.next_level_right
			update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_accept"):
		if current_level.next_scene_path:
			level_selected.emit(current_level.next_scene_path)


func update_level_icon_highlighter_position() -> void:
	$LevelIconHighlighter.global_position = current_level.global_position


func unlock_surrounding_levels() -> void:
	if current_level.next_level_up:
		LevelsData.level_unlocked_status[current_level.next_level_up.level_name] = true
		current_level.next_level_up.modulate.a = 1
	if current_level.next_level_down:
		LevelsData.level_unlocked_status[current_level.next_level_down.level_name] = true
		current_level.next_level_down.modulate.a = 1
	if current_level.next_level_left:
		LevelsData.level_unlocked_status[current_level.next_level_left.level_name] = true
		current_level.next_level_left.modulate.a = 1
	if current_level.next_level_right:
		LevelsData.level_unlocked_status[current_level.next_level_right.level_name] = true
		current_level.next_level_right.modulate.a = 1


func set_current_level_as_complete() -> void:
	print(current_level)
	current_level.modulate.g = 0.3
