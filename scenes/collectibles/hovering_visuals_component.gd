extends Node2D


@onready var visuals: Node2D = $"../Visuals"

var starting_pos
var hover_pos


func _ready() -> void:
	starting_pos = visuals.global_position
	hover_pos = starting_pos + Vector2(0, -4)


func _process(_delta: float) -> void:
	if visuals.global_position == starting_pos:
		var move_tween = get_tree().create_tween()
		move_tween.tween_property(visuals, "global_position", hover_pos, 2).set_trans(Tween.TRANS_SINE)
	elif visuals.global_position == hover_pos:
		var move_tween = get_tree().create_tween()
		move_tween.tween_property(visuals, "global_position", starting_pos, 2).set_trans(Tween.TRANS_SINE)
