extends CanvasLayer


@onready var panel: Panel = $Panel


func fade_in() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "modulate", Color.html("89cd64ff"), 1)


func fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "modulate", Color.html("89cd6400"), 1)
