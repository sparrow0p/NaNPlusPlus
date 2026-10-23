extends CharacterBody2D

@onready var _animation_tree := $AnimationTree

@export var accel := 16.0
@export var friction := 20.0
@export var speed := 600.0

var direction := Vector2.ZERO
var state := "idle"

func change_state() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	match state:
		"idle":
			if direction:
				state = "run"
		"run":
			if not direction:
				state = "idle"
		_:
			pass

func move(delta: float) -> void:
	match state:
		"idle":
			velocity = velocity.lerp(Vector2.ZERO, friction * delta)
		"run":
			velocity = velocity.lerp(direction * speed, accel * delta)
			_animation_tree.set("parameters/blend_position", direction)
	
	move_and_slide()

func _physics_process(delta: float) -> void:
	change_state()
	move(delta)
