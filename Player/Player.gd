class_name Player extends CharacterBody2D

var shot_direction: Vector2
var shot_fired: bool = false
const SHOT = preload("res://Ball/shot.tscn")
var shot_speed: int = 400
var total_bullets: int = 1
var shot_offsets: Array[float]
var can_shoot: bool = true
@onready var line: Line2D = $Line2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	var offset: float = -0.5
	var max_offset: float = 0.5
	var avoid_offset: float = 0.2
	while offset <= max_offset:
		if offset < - avoid_offset or offset > avoid_offset:
			shot_offsets.append(offset)
		offset += 0.05 
		
	line.width = 1
	particles.emitting = false
	BoostManager.boosted.connect(emit_particles)
	
func _process(delta: float) -> void:
	particles.global_position = global_position
	velocity.x = Input.get_axis("left","right") * 200
	if velocity.x < 0:
		sprite.frame = 1
	elif velocity.x > 0:
		sprite.frame = 2
	else:
		sprite.frame = 0
	velocity.y = 0
		

func _physics_process(delta: float) -> void:
	calculate_angle()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if can_shoot:
		if event.is_action_pressed("up") or event.is_action_pressed("mouse_left") or event.is_action_pressed("spacebar"):
			total_bullets = BoostManager.total_bullets
			shoot(total_bullets)
			can_shoot = false
			await get_tree().create_timer(PlayerManager.shoot_timer_delay).timeout
			can_shoot = true
			
func calculate_angle() -> void:
	var mouse_pos = get_global_mouse_position()
	var player_pos = global_position
	shot_direction = Vector2(mouse_pos[0] - player_pos[0],
	 mouse_pos[1] - player_pos[1]).normalized()

	line.clear_points()
	line.add_point(-(line.global_position - mouse_pos))
	line.add_point(line.global_position - player_pos)

func shoot(amount: int) -> void:
	var offset: Vector2 = Vector2.ZERO
	for i in amount:
		var shot = SHOT.instantiate()
		var new_position = global_position
		shot.position = new_position
		shot.velocity = (shot_direction + offset) * shot_speed
		offset = Vector2(shot_offsets.pick_random(),shot_offsets.pick_random())
		get_tree().root.add_child(shot)


func emit_particles() -> void:
	particles.emitting = true
	
	
	
	
	
	
	
	
	
	
	
