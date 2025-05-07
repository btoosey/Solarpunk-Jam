extends Node2D

@export var collectible_group: int
@export var incomplete_sprite_texture: Texture2D
@export var complete_sprite_texture: Texture2D


@onready var collectibles: Node2D = $"../../Collectibles"
@onready var incomplete_sprite: Sprite2D = $IncompleteSprite
@onready var complete_sprite: Sprite2D = $CompleteSprite
@onready var point_light_2d: PointLight2D = $PointLight2D


func _ready() -> void:
	incomplete_sprite.texture = incomplete_sprite_texture
	complete_sprite.texture = complete_sprite_texture

	incomplete_sprite.show()

	if collectibles.has_signal("group_%s_completed" % collectible_group):
		collectibles.connect("group_%s_completed" % collectible_group, _on_group_completed)

	if collectibles.has_signal("group_%s_decompleted" % collectible_group):
		collectibles.connect("group_%s_decompleted" % collectible_group, _on_group_decompleted)


func _on_group_completed() -> void:
	incomplete_sprite.hide()
	complete_sprite.show()
	if collectible_group == 2:
		point_light_2d.show()


func _on_group_decompleted() -> void:
	incomplete_sprite.show()
	complete_sprite.hide()
	if collectible_group == 2:
		point_light_2d.hide()
