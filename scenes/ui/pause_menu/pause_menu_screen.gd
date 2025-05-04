extends CanvasLayer


var paused := false
var pausable := false


func _input(event: InputEvent) -> void:
	if not pausable:
		return

	if event.is_action_pressed("pause_unpause"):
		if paused:
			unpause_game()
		else:
			pause_game()


func unpause_game() -> void:
	get_tree().paused = false
	hide()
	paused = false


func pause_game() -> void:
	get_tree().paused = true
	show()
	paused = true
