extends Area2D


signal collectible_collected
signal collectible_reset

var collected := false
var turn_collected: int


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	collect()


func collect() -> void:
	collected = true
	hide()
	collectible_collected.emit()


func reset_collectible() -> void:
	collected = false
	show()
	collectible_reset.emit()
