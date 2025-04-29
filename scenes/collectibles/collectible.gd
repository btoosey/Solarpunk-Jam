extends Area2D


var collected:= false


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	print("collected")
	collect()


func collect() -> void:
	collected = true
	hide()
