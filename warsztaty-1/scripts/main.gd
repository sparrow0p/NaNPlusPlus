extends Node2D


@onready var sprite1: Sprite2D = $Sprite1

@export var num_export: float = 4.5
@export var sprite2: Sprite2D

var num: float = 3


func _ready() -> void:
	print("Hello World!")
	
	print(do_potęgi(num_export, num))


func do_potęgi(num1: float, num2: float) -> float:
	var answer = pow(num1, num2)
	
	return answer


func _process(_delta: float) -> void:
	color_something()


func color_something():
	if (Input.is_action_just_pressed("1")):
		sprite1.modulate = Color.AQUA
	
	if (Input.is_action_just_pressed("2")):
		sprite2.modulate = Color.RED
