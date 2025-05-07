extends Node2D

@export var collectible_group: int

@onready var collectibles: Node2D = $"../../Collectibles"
@onready var incomplete_sprite: Sprite2D = $IncompleteSprite
@onready var complete_sprite: Sprite2D = $CompleteSprite


func _ready() -> void:
	incomplete_sprite.show()
	if collectibles.has_signal("group_%s_completed" % collectible_group):
		collectibles.connect("group_%s_completed" % collectible_group, _on_group_completed)

	if collectibles.has_signal("group_%s_decompleted" % collectible_group):
		collectibles.connect("group_%s_decompleted" % collectible_group, _on_group_decompleted)


func _on_group_completed() -> void:
	incomplete_sprite.hide()
	complete_sprite.show()
	print("complete shown")

func _on_group_decompleted() -> void:
	incomplete_sprite.show()
	complete_sprite.hide()
	print("incomplete shown")
