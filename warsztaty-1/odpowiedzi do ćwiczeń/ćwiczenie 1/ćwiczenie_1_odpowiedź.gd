extends Node2D


@export var sprite: Sprite2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		#sprite.modulate = Color(randf(), randf(), randf())
		sprite.modulate = Color(0, 0, 0)
	
	if Input.is_action_just_pressed("1"):
		sprite.modulate.r += 0.1;
		sprite.modulate.r = fmod(sprite.modulate.r, 1.0)
	
	if Input.is_action_just_pressed("2"):
		sprite.modulate.g += 0.1;
		sprite.modulate.g = fmod(sprite.modulate.g, 1.0)
	
	if Input.is_action_just_pressed("3"):
		sprite.modulate.b += 0.1;
		sprite.modulate.b = fmod(sprite.modulate.b, 1.0)
