extends Node2D


signal level_complete

@onready var collectibles: Array = get_tree().get_nodes_in_group("collectibles")

var number_collected := 0


func _ready() -> void:
	for c in collectibles:
		c.collectible_collected.connect(_on_collectible_collected)


func _on_collectible_collected() -> void:
	number_collected += 1
	check_collected_collectibles()


func check_collected_collectibles() -> void:
	if collectibles.size() == number_collected:
		level_complete.emit()
