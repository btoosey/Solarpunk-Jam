@tool
class_name LevelIcon
extends Control

@export var level_name := "00"
@export_file("*.tscn") var next_scene_path: String
@export var next_level_up: LevelIcon
@export var next_level_down: LevelIcon
@export var next_level_left: LevelIcon
@export var next_level_right: LevelIcon


func _ready() -> void:
	$Label.text = level_name
