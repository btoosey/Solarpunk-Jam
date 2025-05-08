class_name GridMover
extends Node2D


@export var speed: float

@onready var ground: TileMapLayer = $"../../../Tilemaps/Ground"
@onready var walls: TileMapLayer = $"../../../Tilemaps/Walls"

var is_moving := false
var can_move := false


func _physics_process(_delta: float) -> void:
	if not is_moving:
		return

	if get_parent().global_position == get_parent().character_sprite.global_position:
		is_moving = false
		return

	get_parent().character_sprite.global_position = get_parent().character_sprite.global_position.move_toward(get_parent().global_position, speed)


func move(direction: Vector2i) -> void:
	if not can_move:
		return

	var current_tile: Vector2i = ground.local_to_map(get_parent().global_position)
	var target_tile: Vector2i = current_tile + direction
	var target_tile_data: TileData = walls.get_cell_tile_data(target_tile)


	if target_tile_data != null and target_tile_data.get_custom_data('wall_obstacle'):
		return

	for character in get_tree().get_nodes_in_group("characters"):
		if Vector2i(character.position) == (target_tile * 32 + Vector2i(16,16)):

			var extended_target_tile: Vector2i = target_tile + direction
			var extended_target_tile_data: TileData = walls.get_cell_tile_data(extended_target_tile)

			if extended_target_tile_data != null and extended_target_tile_data.get_custom_data('wall_obstacle'):
				return


	if direction == Vector2i(1, 0):
		get_parent().character_sprite.region_rect.position = (Vector2(0, get_parent().character_type) * Main.CHARACTER_SIZE) + (get_parent().facing_directions.RIGHT * Main.CHARACTER_SIZE)
	elif direction == Vector2i(0, 1):
		get_parent().character_sprite.region_rect.position = (Vector2(0, get_parent().character_type) * Main.CHARACTER_SIZE) + (get_parent().facing_directions.UP * Main.CHARACTER_SIZE)
	elif direction == Vector2i(0, -1):
		get_parent().character_sprite.region_rect.position = (Vector2(0, get_parent().character_type) * Main.CHARACTER_SIZE) + (get_parent().facing_directions.DOWN * Main.CHARACTER_SIZE)
	elif direction == Vector2i(-1, 0):
		get_parent().character_sprite.region_rect.position = (Vector2(0, get_parent().character_type) * Main.CHARACTER_SIZE) + (get_parent().facing_directions.LEFT * Main.CHARACTER_SIZE)


	is_moving = true
	get_parent().global_position = ground.map_to_local(target_tile)
	get_parent().character_sprite.global_position = ground.map_to_local(current_tile)
	current_tile = ground.local_to_map(get_parent().global_position)
