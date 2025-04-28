extends Node2D


@onready var characters: Array = get_tree().get_nodes_in_group("characters")


func _process(_delta: float) -> void:
	if any_moving():
		return

	if Input.is_action_pressed("character_up"):
		move_characters(Vector2i.UP)
	elif Input.is_action_pressed("character_down"):
		move_characters(Vector2i.DOWN)
	elif Input.is_action_pressed("character_left"):
		move_characters(Vector2i.LEFT)
	elif Input.is_action_pressed("character_right"):
		move_characters(Vector2i.RIGHT)


func any_moving() -> bool:
	for character in characters:
		if character.grid_mover.is_moving:
			return true
	return false


func move_characters(direction) -> void:
	get_tree().call_group('characters','move_character', direction)
