extends CharacterBody2D

var direction := 0.0

@export var accel := 6000.0
@export var friction := 6300.0
@export var speed := 600.0
@export var jump_vel := -1200.0

# @onready inicjalizuje zmienną po inicjalizacji jej dzieci
@onready var coyote_timer := $CoyoteTimer

func _physics_process(delta: float) -> void:
	# Siłę grawitacji można zmienić w Project -> Project Settings -> Physics -> 2D
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = jump_vel
		coyote_timer.stop()

	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	var is_on_floor_old = is_on_floor()

	move_and_slide()
	
	if is_on_floor_old and not is_on_floor() and not Input.is_action_just_pressed("ui_accept"):
		coyote_timer.start()
