extends Node

@onready var _parent = $".."

@export var health := 10

func damage(dmg, kb: float = 0, pos: Vector2 = Vector2.ZERO) -> void:
	health -= dmg
	
	if health <= 0:
		if "die" in _parent:
			_parent.die()
		else:
			_parent.queue_free()
	elif "velocity" in _parent and kb and pos:
		_parent.velocity += kb * Vector2(_parent.global_position - pos).normalized()
