extends CharacterBody2D

@onready var _animation_tree := $AnimationTree
@onready var _stone := $"../Stone"

@export var accel := 16.0
@export var friction := 20.0
@export var speed := 600.0

var direction := Vector2.ZERO
var state := "idle"
var speed_mult := 1.0

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
			if _stone.get_cell_tile_data(floor(global_position / 128)):
				speed_mult = _stone.get_cell_tile_data(floor(global_position / 128)).get_custom_data("speed_mult")
			else:
				speed_mult = 1.0
			
			velocity = velocity.lerp(direction * speed * speed_mult, accel * delta)
			_animation_tree.set("parameters/blend_position", direction)
	
	move_and_slide()

func _physics_process(delta: float) -> void:
	change_state()
	move(delta)
