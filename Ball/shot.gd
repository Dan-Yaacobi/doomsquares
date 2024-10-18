class_name Shot extends CharacterBody2D

const SHOT = preload("res://Ball/shot.tscn")
var main_shot: bool = true

@onready var area: Area2D = $Area2D
@onready var in_camera: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var split_amount: int = 0
@onready var shot_size: float = 0.8

var shot_through_left: int = 1
var split_directions: Array[Vector2] = [Vector2(1,-1), Vector2(-1,-1)] #Vector2(1,1),Vector2(-1,1),
var splitted: bool = false

func _ready() -> void:
	if main_shot:
		splitted = true
		shot_through_left = BoostManager.shot_through
		split_amount = BoostManager.split_amount
		shot_size = BoostManager.shot_size
	area.area_entered.connect(destory_shot)
	in_camera.screen_exited.connect(shot_dissapear)
	scale *= shot_size
	pass
	
func _process(delta: float) -> void:
	move_and_slide()
	
func destory_shot(_area: Area2D) -> void:
	var split_chance: bool = [true,false].pick_random()
	if split_chance and splitted:
		splitted = false
		shot_split()
	shot_through_left -= 1
	if shot_through_left <= 0:
		area.area_entered.disconnect(destory_shot)
		queue_free()

func shot_dissapear():
	in_camera.screen_exited.disconnect(shot_dissapear)
	queue_free()

func shot_split() -> void:
	if split_amount == 0:
		return

	for i in split_amount:
		var speed = PlayerManager.player.shot_speed
		var new_shot = SHOT.instantiate()
		var offset = BoostManager.enemy_size * 32
		new_shot.main_shot = false
		new_shot.global_position = global_position + Vector2(randi_range(-offset,offset),-offset)
		new_shot.velocity = [Vector2(randf_range(-1,1),-1),Vector2(randf_range(-1,1),1)].pick_random()*speed
		get_tree().root.add_child.call_deferred(new_shot)
		
	
