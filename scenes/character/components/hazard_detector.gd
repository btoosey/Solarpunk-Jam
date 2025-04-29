class_name HazardDetector
extends Node2D


signal touched_hazard


func collision_with_hazard() -> void:
	touched_hazard.emit()
