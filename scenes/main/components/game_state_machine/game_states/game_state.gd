class_name GameState
extends Node

@warning_ignore("unused_signal")
signal transition_requested(from: GameState, to: State)

enum State {START, LEVEL_SELECT, PLAY}

@export var state: State


func enter() -> void:
	pass


func exit() -> void:
	pass
