extends CharacterBody3D

@onready var _sprite_2d := $Sprite3D
@onready var _animation_tree := $AnimationTree

@export var accel := 16.0
@export var jump_accel := 6.0
@export var friction := 20.0
@export var speed := 8.0
@export var jump_vel := 12.0

var direction := Vector2.ZERO
var input_vel := Vector2.ZERO
var state := "idle"

func change_state() -> void:
	match state:
		"idle":
			if direction:
				state = "run"
		"run":
			if not direction:
				state = "idle"
		"jump":
			if is_on_floor():
				state = "run" if direction else "idle"
		_:
			pass

func move(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_vel
		state = "jump"
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		_sprite_2d.flip_h = direction.x < 0
		_animation_tree.set("parameters/idle/blend_position", direction)
		_animation_tree.set("parameters/run/blend_position", direction)
		_animation_tree.set("parameters/jump/blend_position", direction)
	
	input_vel = Vector2(velocity.x, velocity.z)
	match state:
		"idle":
			input_vel = input_vel.lerp(Vector2.ZERO, friction * delta)
		"run":
			input_vel = input_vel.lerp(direction * speed, accel * delta)
		"jump":
			input_vel = input_vel.lerp(direction * speed, jump_accel * delta)
	
	velocity = (transform.basis * Vector3(input_vel.x, velocity.y, input_vel.y))
	
	move_and_slide()

func _physics_process(delta: float) -> void:
	change_state()
	move(delta)
