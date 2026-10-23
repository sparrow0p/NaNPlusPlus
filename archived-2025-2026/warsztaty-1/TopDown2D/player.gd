extends CharacterBody2D

# W GD skrypcie, podobnie jak w Pythonie, typ zmiennych jest dynamiczny.
# Jeżeli chcemy aby nasze zminne nie zmieniały swojego typu możemy użyć ":"
# var liczba_calkowita: int
# ":=" jednoczeście nadaje zmiennej wartość i typ
# ": 5" zamieni typ zmiennej na int, a ": 5.0" na float
var direction := Vector2.ZERO

# "@export" pozwala na zmiane wartości zmiennej w properties menu po prawej stronie
@export var accel := 16.0
@export var friction := 20.0
@export var speed := 500.0

# Wbudowana funkcja wywoływana co klatkę. Powinna symulować procesy fizyczne, do
# symulacji procesów logicznych powinna być użyta funkcja "func _process(delta)"
# Wszystkie wbudowane zmienne i funkcje są wymienione i opisane w Docu
# F1 -> (nazwa nodu, do którego doczepiony jest skrypt)
# Różne nody mają różne wbudowane elementy.
func _physics_process(delta: float) -> void:
	# Input to objekt z wieloma funkcjami, które służą do odczytu naciśnięć klawiszy i ruchu myszy
	# Input.is_action_just_pressed("przycisk") zwraca true jeżeli to jest pierwsza klatka, w kórej dany przycisk był wciśnięty
	# Input.get_action_strength("przycisc") zwraca czy dany klawisz jest wciśnięty
	# Input.get_axis("p1", "p2") zwraca liczbę między -1 a 1 równą p2 - p1
	# Input.get_vector("p1", "p2", "p3", "p4") zwraca wektor (p2 - p1, p4 - p3)
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = velocity.lerp(direction.normalized() * speed, accel * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)

	move_and_slide()

# inne przydatne wbudowane funkcje:
# func _init(): funkcja uruchamiana raz, przy inicjalizacji objektu
# func _ready() -> void: funkcja uruchamiana raz, po inicjalizacji wszustkich dzieci objektu
# func _process(delta): funkcja uruchamiana co klatkę
