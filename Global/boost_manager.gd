extends Node

signal boosted

var split_amount: int = 0
var shot_size: float = 0.8
var enemy_size: float = 1.0
var shot_through: int = 1
var summon_speed: float = 1.2
var total_bullets: int = 1

var boost_summon_time: float = 10.0
var boosts: Array[int] = [0,1,2,3,4,5]
var boosts_left: Array[int] = [0,1,2,3,4,5]

func boost_acquired(boost_number: int) -> void:
	if boost_number == 0:
		enemy_size *= 1.1
	elif boost_number == 1:
		split_amount += 1
	elif boost_number == 2:
		shot_size *= 1.1
	elif boost_number == 3:
		shot_through += 1
	elif boost_number == 4:
		summon_speed += 0.05
	elif boost_number == 5:
		total_bullets += 1
	boosted.emit()

func reset_boosts() -> void:
	split_amount = 0
	shot_size = 0.8
	enemy_size = 1.0
	shot_through = 1
	summon_speed = 1.5
	total_bullets = 1
	boost_summon_time = 10.0
