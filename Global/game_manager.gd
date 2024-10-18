extends Node
#
@export var shots_next: int = 3
var total_shots: int = 3

var enemy_hp: int = 3
var spawn_points: Array[Vector2] = [Vector2(302,230),Vector2(139,261),Vector2(563,236),
Vector2(86,304),Vector2(523,290),]
var game_over: bool = false
var total_enemies_killed: int = 0

signal set_point()

func _ready() -> void:
	PlayerManager.summoned_player.connect(set_spawn_point)
	#await get_tree().create_timer(0.5).timeout
	#set_spawn_point()
	
func _process(delta: float) -> void:
	if total_shots >= shots_next:

		set_spawn_point()
		total_shots = 0
		shots_next = randi_range(3,5)
	
func set_spawn_point() -> void:
	set_point.emit(spawn_points.pick_random())
