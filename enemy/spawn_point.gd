class_name SpawnPoint extends Node2D

signal send_position()

func _ready() -> void:
	send_position.emit(global_position)
	
#func _process(delta: float) -> void:
	#change_spawn_position()
#
#func change_spawn_position() -> void:
	#if GameManager.total_shots >= 10:
		#global_position = Vector2.ZERO
