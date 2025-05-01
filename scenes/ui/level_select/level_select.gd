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
		current_level = current_level.next_level_up
		update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_down") and current_level.next_level_down:
		current_level = current_level.next_level_down
		update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_left") and current_level.next_level_left:
		current_level = current_level.next_level_left
		update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_right") and current_level.next_level_right:
		current_level = current_level.next_level_right
		update_level_icon_highlighter_position()
	if event.is_action_pressed("ui_accept"):
		if current_level.next_scene_path:
			level_selected.emit(current_level.next_scene_path)


func update_level_icon_highlighter_position() -> void:
	$LevelIconHighlighter.global_position = current_level.global_position
