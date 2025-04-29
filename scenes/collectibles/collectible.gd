extends Area2D


signal collectible_collected

var collected:= false


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	collect()


func collect() -> void:
	collected = true
	hide()
	collectible_collected.emit()
