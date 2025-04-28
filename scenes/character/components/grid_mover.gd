class_name GridMover
extends Node2D


@export var speed: float

@onready var ground: TileMapLayer = $"../../../Tilemaps/Ground"

var is_moving := false


func _physics_process(_delta: float) -> void:
	if not is_moving:
		return

	if get_parent().global_position == get_parent().character_sprite.global_position:
		is_moving = false
		return

	get_parent().character_sprite.global_position = get_parent().character_sprite.global_position.move_toward(get_parent().global_position, speed)


func move(direction: Vector2i) -> void:
	var current_tile: Vector2i = ground.local_to_map(get_parent().global_position)
	var target_tile: Vector2i = current_tile + direction

	get_parent().global_position = ground.map_to_local(target_tile)
	get_parent().character_sprite.global_position = ground.map_to_local(current_tile)
	current_tile = ground.local_to_map(get_parent().global_position)

	is_moving = true
