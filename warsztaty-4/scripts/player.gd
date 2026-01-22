extends "res://scripts/character.gd"

func change_state() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	super()

func die() -> void:
	print("dead")
	queue_free()
