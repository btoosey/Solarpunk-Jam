@tool
extends Area2D


signal collectible_collected
signal collectible_reset

@export var stats: CollectibleStats : set = set_stats

@onready var sprite_2d: Sprite2D = $Visuals/Sprite2D

var collected := false
var turn_collected: int
var type: int


func set_stats(value: CollectibleStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	sprite_2d.texture = value.collectible_skin
	type = value.collectible_type


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return

	if body.character_type == type:
		collect()


func collect() -> void:
	collected = true
	hide()
	collectible_collected.emit()


func reset_collectible() -> void:
	collected = false
	show()
	collectible_reset.emit()
