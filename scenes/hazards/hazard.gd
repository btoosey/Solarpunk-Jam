extends Node2D


func _on_body_entered(body: Node2D) -> void:
	if !body.can_interact:
		return

	body.butterfly_anim.show()
	body.butterfly_anim.play()

	body.hazard_detector.collision_with_hazard()
