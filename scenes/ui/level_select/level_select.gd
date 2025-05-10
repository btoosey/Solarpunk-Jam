extends CanvasLayer


signal level_selected(path)

@onready var current_level: LevelIcon = $LevelIcon1
@onready var timer: Timer = $Timer

const LEVEL_ICON_COMPLETE = preload("res://assets/sprites/ui/level_select/level_icons/level_icon_complete.png")
const LEVEL_ICON_UNLOCKED = preload("res://assets/sprites/ui/level_select/level_icons/level_icon_unlocked.png")

var enabled := false


func _ready() -> void:
	update_level_icon_highlighter_position()
	unlock_level(current_level)


func _input(event: InputEvent) -> void:
	if not enabled:
		return

	if event.is_action_pressed("level_select_up") and current_level.next_level_up:
		if LevelsData.level_unlocked_status[current_level.next_level_up.level_name]:
			current_level = current_level.next_level_up
			update_level_icon_highlighter_position()
	if event.is_action_pressed("level_select_down") and current_level.next_level_down:
		if LevelsData.level_unlocked_status[current_level.next_level_down.level_name]:
			current_level = current_level.next_level_down
			update_level_icon_highlighter_position()
	if event.is_action_pressed("level_select_left") and current_level.next_level_left:
		if LevelsData.level_unlocked_status[current_level.next_level_left.level_name]:
			current_level = current_level.next_level_left
			update_level_icon_highlighter_position()
	if event.is_action_pressed("level_select_right") and current_level.next_level_right:
		if LevelsData.level_unlocked_status[current_level.next_level_right.level_name]:
			current_level = current_level.next_level_right
			update_level_icon_highlighter_position()
	if event.is_action_pressed("level_select"):
		if current_level.next_scene_path:
			enabled = false
			timer.start()
			level_selected.emit(current_level.next_scene_path)


func update_level_icon_highlighter_position() -> void:
	$LevelIconHighlighter.global_position = current_level.marker_2d.global_position


func unlock_surrounding_levels() -> void:
	if current_level.next_level_up:
		unlock_level(current_level.next_level_up)
	if current_level.next_level_down:
		unlock_level(current_level.next_level_down)
	if current_level.next_level_left:
		unlock_level(current_level.next_level_left)
	if current_level.next_level_right:
		unlock_level(current_level.next_level_right)


func set_current_level_as_complete() -> void:
	current_level.texture_rect.texture = LEVEL_ICON_COMPLETE
	current_level.label.label_settings.font_color = Color.html("89cd64")


func unlock_level(level) -> void:
	if LevelsData.level_unlocked_status[level.level_name] == true:
		return

	LevelsData.level_unlocked_status[level.level_name] = true
	level.texture_rect.texture = LEVEL_ICON_UNLOCKED
	level.label.show()


func _on_timer_timeout() -> void:
	enabled = true
