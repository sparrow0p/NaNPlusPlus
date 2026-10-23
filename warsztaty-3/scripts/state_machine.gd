extends Node
class_name StateMachine


@export var current_state: State

var states: Dictionary = {}


func _ready() -> void:
	for child in get_children() as Array[State]:
		states[child.name] = child
		child.state_machine = self
		child._state_ready()


func _input(event: InputEvent) -> void:
	if current_state:
		current_state._state_input(event)


func _process(delta: float) -> void:
	if current_state:
		current_state._state_process(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state._state_physics_process(delta)


func change_state(state_name: String):
	if current_state:
		current_state._state_exit()
	
	current_state = states[state_name]
	
	current_state._state_ready()
