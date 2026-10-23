extends CharacterBody2D


@export_range(1, 300, 1, "suffix:px/s") var walk_speed: float = 90
@export_range(1, 300, 1, "suffix:px/s") var run_speed: float = 150
@export_range(1, 3000, 1, "suffix:px/s^2") var acceleration: float = 1700
@export_range(1, 3000, 1, "suffix:px/s^2") var deceleration: float = 1800

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2


func _physics_process(delta: float) -> void:
	direction = Input.get_vector("a", "d", "w", "s")
	
	# move(delta)
	move_ćwiczenie(delta)
	
	move_and_slide()


func move(delta: float) -> void:
	if direction:
		velocity = velocity.move_toward(direction * run_speed, acceleration * delta)
		sprite.animation = "run"
		
		if direction.x:
			sprite.flip_h = direction.x < 0.0
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		sprite.animation = "idle"


func move_ćwiczenie(delta: float) -> void:
	if direction:
		if Input.is_action_pressed("shift"):
			velocity = velocity.move_toward(direction * run_speed, acceleration * delta)
			sprite.animation = "run"
		else:
			velocity = velocity.move_toward(direction * walk_speed, acceleration * delta)
			sprite.animation = "walk"
		
		if direction.x:
			sprite.flip_h = direction.x < 0.0
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		sprite.animation = "idle"
