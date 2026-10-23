extends CharacterBody2D

@onready var _sprite_2d := $Sprite2D
@onready var _animation_tree := $AnimationTree
@onready var _state_machine = _animation_tree.get("parameters/playback")

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
				_state_machine.travel("run")
		"run":
			if not direction:
				state = "idle"
				_state_machine.travel("idle")
		_:
			pass

func move(delta: float) -> void:
	match state:
		"idle":
			velocity = velocity.lerp(Vector2.ZERO, friction * delta)
		"run":
			velocity = velocity.lerp(direction * speed, accel * delta)
			_sprite_2d.flip_h = direction.x < 0
			_animation_tree.set("parameters/idle/blend_position", direction)
			_animation_tree.set("parameters/run/blend_position", direction)
	
	move_and_slide()

func _physics_process(delta: float) -> void:
	change_state()
	move(delta)
