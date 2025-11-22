extends StaticBody2D

# liczba / objekt o niezmiennej wartości
const SPEED = 300.0

var screen_size_x := DisplayServer.window_get_size().x
var direction := 1

@onready var size = $CollisionShape2D.shape.extents.x

func _process(delta: float) -> void:
	if position.x + size > screen_size_x:
		direction = -1
	elif position.x - size < 0:
		direction = 1
	
	position.x += direction * SPEED * delta
