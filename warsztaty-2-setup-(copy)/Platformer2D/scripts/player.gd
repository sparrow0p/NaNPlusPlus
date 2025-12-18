extends CharacterBody2D

@onready var _coyote_timer := $CoyoteTimer
@onready var _animated_sprite_2d := $AnimatedSprite2D

@export var accel := 6000.0
@export var friction := 1500.0
@export var speed := 600.0
@export var jump_vel := -1200.0

var direction := 0.0
var was_on_floor := true

func move(delta:float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or _coyote_timer.time_left):
		velocity.y = jump_vel
	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, accel)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)

	was_on_floor = is_on_floor()
  
	move_and_slide()
	
	if was_on_floor and not is_on_floor() and not Input.is_action_just_pressed("ui_accept"):
		_coyote_timer.start()

func animate() -> void:
	if direction:
		_animated_sprite_2d.flip_h = direction < 0
	
	if Input.is_action_just_pressed("ui_accept") and was_on_floor:
		_animated_sprite_2d.play("jump")
	elif was_on_floor and not is_on_floor():
		_animated_sprite_2d.play("fall")
	elif is_on_floor():
		if velocity.x != 0:
			_animated_sprite_2d.play("run")
		else:
			_animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	move(delta)
	animate()
