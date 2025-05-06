@tool
extends Node2D
class_name Character


@export var grid_mover: GridMover
@export var hazard_detector: HazardDetector
@export var character_type: int

@onready var character_sprite: Sprite2D = $CharacterSprite

var can_interact := true

var facing_directions := {
	"UP": Vector2(0, 0),
	"RIGHT": Vector2(1, 0),
	"DOWN": Vector2(2, 0),
	"LEFT": Vector2(3, 0)
}


func _ready() -> void:
	character_sprite.region_rect.position = (Vector2(0, character_type) * Main.CHARACTER_SIZE) + (facing_directions.UP * Main.CHARACTER_SIZE)


func move_character(direction: Vector2i) -> void:
	grid_mover.move(direction)
