@tool
extends Node2D
class_name Character


@export var stats: CharacterStats : set = set_stats
@export var grid_mover: GridMover
@export var hazard_detector: HazardDetector
@export var character_type: int

@onready var character_sprite: Sprite2D = $CharacterSprite

var can_interact := true


func set_stats(value: CharacterStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	character_sprite.texture = value.character_skin


func move_character(direction: Vector2i) -> void:
	grid_mover.move(direction)
