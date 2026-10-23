extends CharacterBody2D

@export var accel := 16.0
@export var friction := 20.0
@export var speed := 600.0

var direction := Vector2.ZERO

func change_state() -> void:
	pass

func move(delta: float) -> void:
	pass
	
	move_and_slide()

func _physics_process(delta: float) -> void:
	change_state()
	move(delta)
