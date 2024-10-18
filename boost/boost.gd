class_name Boost extends CharacterBody2D

@onready var area: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D

var sprites: Array[int] = [0,16,32]
var current_boost: int = 1

func _ready() -> void:
	area.area_entered.connect(boosted)
	current_boost = randi_range(0,5)
	
	#if BoostManager.boosts_left.size() == 0:
		#BoostManager.boosts_left = BoostManager.boosts.duplicate()
	#current_boost = BoostManager.boosts_left.pick_random()
	#BoostManager.boosts_left.erase(current_boost)

	sprite.frame = current_boost
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func boosted(_value) -> void:
	BoostManager.boost_acquired(current_boost)
	queue_free()
