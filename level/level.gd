class_name Level extends Node2D

@onready var spawn_point: SpawnPoint = $SpawnPoint
@onready var timer: Timer = $Timer
@onready var label: Label = $CanvasLayer/Label
@onready var total_kills: Label = $CanvasLayer/TotalKills
@onready var spawn: Array[Vector2] 
@onready var can_summon: bool = true
@onready var can_boost: bool = true

const RED_BLOCK = preload("res://enemy/RedBlock/RedBlock.tscn")
const BOOST = preload("res://boost/boost.tscn")
const START_MENU = "res://Start Menu/StartMenu.tscn"
@export var boost_summon: float = 10.0



func _ready() ->void:
	PlayerManager.in_menu = false
	var init_spawn_pos = GameManager.spawn_points.pick_random()
	boost_summon = BoostManager.boost_summon_time
	spawn.append(init_spawn_pos)
	spawn_point.global_position = init_spawn_pos
	timer.wait_time = boost_summon
	GameManager.set_point.connect(update_position)
	timer.timeout.connect(summon_boost)
	label.visible = false
	GameManager.game_over = false
	pass

func _process(delta: float) -> void:
	total_kills.text = "Total Kills: " + str(GameManager.total_enemies_killed)
	if not GameManager.game_over:
		if spawn.size() == 0:
			return
		if can_summon:
			summon_enemies()
	else:
		can_boost = false
		label.visible = true
		for child in get_tree().root.get_children():
			if child is Enemy or child is Boost:
				child.queue_free()
		await get_tree().create_timer(2).timeout
		back_to_menu()
		
func update_position(_position: Vector2) -> void:
	if can_summon:
		spawn.clear()
		spawn.append(_position)
		spawn_point.global_position = _position
		if BoostManager.summon_speed > 0.001:
			BoostManager.summon_speed *= 0.99
			if boost_summon > 5.0:
				boost_summon -= 0.01

func summon_enemies() -> void:
	can_summon = false
	var spawn_from: Vector2 = spawn.pick_random()
	var block = RED_BLOCK.instantiate()
	block.global_position = spawn_from + Vector2(randf_range(-20,20),randf_range(-20,20))
	get_tree().root.add_child(block)
	await get_tree().create_timer(BoostManager.summon_speed).timeout
	can_summon = true
	GameManager.total_shots += 1

func summon_boost() -> void:
	if can_boost:
		var boost = BOOST.instantiate()
		boost.global_position = Vector2(randf_range(50,600), 100)
		boost.velocity = Vector2(0,100)
		get_tree().root.add_child(boost)
	
func back_to_menu() -> void:
	PlayerManager.summon_player = false
	PlayerManager.game_started = false
	get_tree().change_scene_to_file(START_MENU)

	
	
