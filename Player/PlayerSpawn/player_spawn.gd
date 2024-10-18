class_name PlayerSpawn extends Node2D

func _ready() -> void:
	PlayerManager.player_position = global_position
	visible = false
