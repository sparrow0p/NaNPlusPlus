extends CharacterBody3D


var direction: Vector2 = Vector2.ZERO
var speed = 5
var jump_speed = 5


func _input(event):
	direction = Input.get_vector("left", "right", "forward", "backward")


func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var movement_dir = transform.basis * Vector3(direction.x, 0, direction.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	
	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
