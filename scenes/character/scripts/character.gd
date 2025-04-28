@tool
extends Node2D
class_name Character


@export var stats: CharacterStats : set = set_stats
@export var grid_mover: GridMover

@onready var character_sprite: Sprite2D = $CharacterSprite


func set_stats(value: CharacterStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	character_sprite.texture = value.character_skin


func move_character(direction: Vector2i) -> void:
	grid_mover.move(direction)
