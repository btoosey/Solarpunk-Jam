extends Node2D


signal undo
signal characters_moved

@onready var characters: Array = get_tree().get_nodes_in_group("characters")


func _ready() -> void:
	for c in characters: 
		c.hazard_detector.touched_hazard.connect(_on_character_touched_hazard)


func _process(_delta: float) -> void:
	if any_moving():
		return

	if Input.is_action_pressed("character_up"):
		move_characters(Vector2i.UP)
		characters_moved.emit()
	elif Input.is_action_pressed("character_down"):
		move_characters(Vector2i.DOWN)
		characters_moved.emit()
	elif Input.is_action_pressed("character_left"):
		move_characters(Vector2i.LEFT)
		characters_moved.emit()
	elif Input.is_action_pressed("character_right"):
		move_characters(Vector2i.RIGHT)
		characters_moved.emit()
	elif Input.is_action_just_pressed("undo"):
		undo.emit()


func any_moving() -> bool:
	for character in characters:
		if character.grid_mover.is_moving:
			return true
	return false


func move_characters(direction) -> void:
	get_tree().call_group('characters','move_character', direction)


func _on_character_touched_hazard() -> void:
	for c in characters:
		c.grid_mover.can_move = false
		c.can_interact = false
	await get_tree().create_timer(1).timeout

	get_tree().reload_current_scene()
