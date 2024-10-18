extends Node

const PLAYER = preload("res://Player/Player.tscn")
var player: Player
var player_position: Vector2 = Vector2.ZERO
var summon_player: bool = true
var game_started: bool = false
var shoot_timer_delay: float = 0.2
var in_menu: bool = true
signal summoned_player

func _process(delta: float) -> void:
	if not in_menu:
		if not summon_player:
			add_player_instance()
			set_player_position()
			summon_player = true
			game_started = true
			summoned_player.emit()
		if game_started:
			if player_position == Vector2.ZERO:
				return
			player_position = player.global_position
	else:
		remove_player_instance()
func add_player_instance() -> void:
	player = PLAYER.instantiate()
	get_tree().root.add_child.call_deferred(player)

func set_player_position() -> void:
	player.global_position = Vector2(336,496)

func remove_player_instance() -> void:
	for child in get_tree().root.get_children():
		if child is Player:
			child.queue_free()
