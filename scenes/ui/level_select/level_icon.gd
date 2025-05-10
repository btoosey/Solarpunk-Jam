@tool
class_name LevelIcon
extends Control


@export var level_name := "Level_01"
@export var level_name_shorthand := "00"
@export_file("*.tscn") var next_scene_path: String
@export var next_level_up: LevelIcon
@export var next_level_down: LevelIcon
@export var next_level_left: LevelIcon
@export var next_level_right: LevelIcon

@onready var texture_rect: TextureRect = $TextureRect
@onready var marker_2d: Marker2D = $Marker2D
@onready var label: Label = $Label


func _ready() -> void:
	label.text = level_name_shorthand
