extends CharacterBody2D


@export_range(1, 300, 1, "suffix:px/s") var speed: float = 70
@export_range(1, 3000, 1, "suffix:px/s^2") var acceleration: float = 1700
@export_range(1, 3000, 1, "suffix:px/s^2") var deceleration: float = 1800

@export var player: CharacterBody2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2


func _physics_process(delta: float) -> void:
	move(delta)
	
	move_and_slide()


func move(delta: float) -> void:
	var distance: float = global_position.distance_to(player.global_position)
	
	if distance < 150 and distance > 20:
		direction = (player.global_position - global_position).normalized()
	else:
		direction = Vector2.ZERO
	
	if direction:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
		sprite.animation = "run"
		
		if direction.x:
			sprite.flip_h = direction.x < 0.0
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		sprite.animation = "idle"
