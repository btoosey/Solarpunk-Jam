extends Node2D


signal group_0_completed
signal group_1_completed
signal group_2_completed
signal group_0_decompleted
signal group_1_decompleted
signal group_2_decompleted
signal all_collectibles_collected

@onready var collectibles: Array = get_tree().get_nodes_in_group("collectibles")

var number_collected := 0
var collectibles_type_0_group := []
var collectibles_type_1_group := []
var collectibles_type_2_group := []

var group_0_complete := false
var group_1_complete := false
var group_2_complete := false


func _ready() -> void:
	for c in collectibles:
		c.collectible_collected.connect(_on_collectible_collected.bind(c))
		c.collectible_reset.connect(_on_collectible_reset.bind(c))
		if c.type == 0:
			collectibles_type_0_group.append(c)
		if c.type == 1:
			collectibles_type_1_group.append(c)
		if c.type == 2:
			collectibles_type_2_group.append(c)


func _on_collectible_collected(collectible) -> void:
	collectible.turn_collected = get_parent().turn_number
	number_collected += 1
	check_groups_completion()
	check_collected_collectibles()


func check_collected_collectibles() -> void:
	if collectibles.size() == number_collected:
		all_collectibles_collected.emit()


func check_groups_completion() -> void:
	if not collectibles_type_0_group.is_empty() and not group_0_complete and collectibles_type_0_group.all(func(c): return c.collected):
		group_0_complete = true
		group_0_completed.emit()

	if not collectibles_type_1_group.is_empty() and not group_1_complete and collectibles_type_1_group.all(func(c): return c.collected):
		group_1_complete = true
		group_1_completed.emit()

	if not collectibles_type_2_group.is_empty() and not group_2_complete and collectibles_type_2_group.all(func(c): return c.collected):
		group_2_complete = true
		group_2_completed.emit()


func _on_collectible_reset(collectible) -> void:
	collectible.turn_collected = 0
	number_collected -= 1
	check_groups_decompleted()


func check_groups_decompleted() -> void:
	if not collectibles_type_0_group.is_empty() and group_0_complete and not collectibles_type_0_group.all(func(c): return c.collected):
		group_0_complete = false
		group_0_decompleted.emit()

	if not collectibles_type_1_group.is_empty() and group_1_complete and not collectibles_type_1_group.all(func(c): return c.collected):
		group_1_complete = false
		group_1_decompleted.emit()

	if not collectibles_type_2_group.is_empty() and group_2_complete and not collectibles_type_2_group.all(func(c): return c.collected):
		group_2_complete = false
		group_2_decompleted.emit()
