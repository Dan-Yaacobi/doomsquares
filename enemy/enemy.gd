class_name Enemy extends CharacterBody2D

@onready var player_hit: Area2D = $PlayerHit
@onready var area: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var animation: Dictionary = {3:"move", 2: "move_2",1: "move_3" }
var spawn_points: Array[Vector2] 
var direction: Vector2
var size: float = 1.0
var hp_left: int = 1

func _ready() -> void:
	hp_left = GameManager.enemy_hp
	scale *= BoostManager.enemy_size
	area.area_entered.connect(destroyed)
	player_hit.area_entered.connect(game_over)
	pass
	
func _process(delta: float) -> void:
	animation_player.play(animation[hp_left])
	calc_direction_to_player()
	velocity = direction*80
	move_and_slide()
	
func calc_direction_to_player() -> void:
	direction = Vector2(PlayerManager.player_position[0] - global_position[0]
	,PlayerManager.player_position[1] - global_position[1]).normalized()

func destroyed(_value) -> void:
	hp_left -= 1
	if hp_left == 0:
		GameManager.total_enemies_killed += 1
		area.area_entered.disconnect(destroyed)
		queue_free()
	
func game_over(_value) -> void:
	GameManager.game_over = true
	
