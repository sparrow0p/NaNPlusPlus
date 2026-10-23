extends CharacterBody3D

@onready var _camera_pivot = $CameraPivot
@onready var _camera = $CameraPivot/Camera

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.0032
var max_zoom: float = 3

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		_camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		_camera_pivot.rotation.x = clampf(_camera_pivot.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	
	if event.is_action_pressed("left_click"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("zoom_in"):
		if _camera.position.z - 0.1 > 0:
			var tween = get_tree().create_tween()
			tween.tween_property(_camera, "position", _camera.position + Vector3(0, 0, -0.1), 0.05)
		else:
			_camera.position.z = 0
	
	if event.is_action_pressed("zoom_out"):
		if _camera.position.z + 0.1 < max_zoom:
			var tween = get_tree().create_tween()
			tween.tween_property(_camera, "position", _camera.position + Vector3(0, 0, 0.1), 0.05)
		else:
			_camera.position.z = max_zoom


func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "backward")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed

	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
