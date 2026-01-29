extends "res://scripts/character.gd"

@onready var _player: CharacterBody2D = $"../Player"
@onready var _agent: NavigationAgent2D = $NavigationAgent2D
@onready var _attack_cd: Timer = $Timer

func change_state() -> void:
	#var player_vec := Vector2(_player.global_position - global_position)
	#if player_vec.length() < 300 and player_vec.length() > 50:
		#direction = player_vec.normalized()
	#else:
		#direction = Vector2.ZERO
	
	if _player:
		_agent.set_target_position(_player.global_position)
		if not _agent.is_navigation_finished() and global_position.distance_to(_player.global_position) > 50:
			direction = global_position.direction_to(_agent.get_next_path_position())
		else:
			direction = Vector2.ZERO
	else:
		direction = Vector2.ZERO
	
	super()

func attack_player() -> void:
	if _attack_cd.is_stopped():
		if global_position.distance_to(_player.global_position) < 50:
			_attack_cd.start()
			if _player.has_node("HealthComponent"):
				var hc = _player.get_node("HealthComponent")
				hc.damage(1, 3000, global_position)

func _physics_process(delta: float) -> void:
	super(delta)
	if _player:
		attack_player()
