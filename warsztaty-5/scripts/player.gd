extends CharacterBody3D

@onready var _fpc: Camera3D = $FPC
@onready var _tpc: Camera3D = $"TPC Pivot/TPC"
@onready var _tpc_pivot = $"TPC Pivot"

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.0032
var camera = 0

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		_fpc.rotate_x(-event.relative.y * mouse_sensitivity)
		_fpc.rotation.x = clampf(_fpc.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		
		_tpc_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		_tpc_pivot.rotation.x = clampf(_tpc_pivot.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	
	if event.is_action_pressed("left_click"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("change_perspective"):
		if camera:
			_fpc.make_current()
			camera = 0
		else:
			_tpc.make_current()
			camera = 1

func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "backward")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed

	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
