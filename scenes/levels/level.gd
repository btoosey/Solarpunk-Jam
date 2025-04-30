extends Node2D


@onready var characters: Node2D = $Characters
@onready var collectibles: Node2D = $Collectibles

var level_log: Array
var turn_number := 0


func _ready() -> void:
	characters.undo.connect(_on_undo)
	characters.characters_moved.connect(log_level_state)
	collectibles.level_complete.connect(_on_level_completed)
	log_level_state()


func _on_undo() -> void:
	if level_log.size() > 1:
		var chara_index := 0
		for chara in characters.get_children():
			chara.position = level_log[-2][chara_index]
			chara_index += 1

		for col in collectibles.get_children():
			if col.turn_collected == level_log.size():
				col.reset_collectible()

		level_log.pop_back()
		turn_number -= 1


func log_level_state() -> void:
	var new_state := []

	for c in characters.get_children():
		new_state.append(c.global_position)

	if level_log.size() == 0 or level_log[-1] != new_state:
		level_log.append(new_state)
		turn_number += 1


func _on_level_completed() -> void:
	print("level complete")
