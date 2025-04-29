extends Node2D


signal level_complete

@onready var collectibles: Array = get_tree().get_nodes_in_group("collectibles")

var number_collected := 0


func _ready() -> void:
	for c in collectibles:
		c.collectible_collected.connect(_on_collectible_collected.bind(c))
		c.collectible_reset.connect(_on_collectible_reset.bind(c))


func _on_collectible_collected(collectible) -> void:
	collectible.turn_collected = get_parent().turn_number
	number_collected += 1
	check_collected_collectibles()


func check_collected_collectibles() -> void:
	if collectibles.size() == number_collected:
		level_complete.emit()


func _on_collectible_reset(collectible) -> void:
	collectible.turn_collected = 0
	number_collected -= 1
