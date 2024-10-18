class_name StartMenu extends Control

@onready var easy_button: Button = $HFlowContainer/EasyButton
@onready var normal_button: Button = $HFlowContainer/NormalButton
@onready var crazy_button: Button = $HFlowContainer/CrazyButton
@onready var info: Button = $Info

const PLAYGROUND = "res://level/playground.tscn"
const HOW_TO_PLAY = "res://Start Menu/HowToPlay.tscn"

func _ready() -> void:
	BoostManager.reset_boosts()
	PlayerManager.in_menu = true
	easy_button.pressed.connect(easy_mode)
	normal_button.pressed.connect(normal_mode)
	crazy_button.pressed.connect(crazy_mode)
	info.pressed.connect(how_to_play)

func easy_mode() -> void:
	GameManager.enemy_hp = 1
	BoostManager.boost_summon_time = 3.0
	PlayerManager.shoot_timer_delay = 0.2
	start_game()
	
func crazy_mode() -> void:
	GameManager.enemy_hp = 3
	BoostManager.boost_summon_time = 5.0
	BoostManager.summon_speed = 0.3
	PlayerManager.shoot_timer_delay = 0.0
	start_game()
	
func normal_mode() -> void:
	GameManager.enemy_hp = 3
	BoostManager.boost_summon_time = 10.0
	PlayerManager.shoot_timer_delay = 0.2
	start_game()

func start_game() -> void:
	PlayerManager.summon_player = false
	get_tree().change_scene_to_file(PLAYGROUND)

func how_to_play() -> void:
	get_tree().change_scene_to_file(HOW_TO_PLAY)
	pass
