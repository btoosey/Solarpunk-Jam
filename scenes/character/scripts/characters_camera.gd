extends Camera2D


@export var movement_enabled: bool
@onready var characters: Array = get_tree().get_nodes_in_group("characters")


func _ready():
	update_camera_position()


func _physics_process(_delta):
	if movement_enabled:
		update_camera_position()


func update_camera_position() -> void:
	var camera_position: Vector2 = Vector2.ZERO
	for character in characters:
		camera_position += character.character_sprite.global_position
	global_position = camera_position / characters.size()
