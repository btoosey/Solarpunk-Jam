extends Node2D


func _on_body_entered(body: Node2D) -> void:
	if !body.can_interact:
		return

	body.hazard_detector.collision_with_hazard()
