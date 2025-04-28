extends Node2D
class_name Character


@export var grid_mover: GridMover

@onready var character_sprite: Sprite2D = $CharacterSprite


func move_character(direction: Vector2i) -> void:
	grid_mover.move(direction)
