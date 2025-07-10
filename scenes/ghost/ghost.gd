extends CharacterBody2D

##################################################
const MOVING_SPEED = 50.0

var is_moving_down: bool = true

##################################################
func _ready() -> void:
	add_to_group("Enemy")

##################################################
func _physics_process(delta: float) -> void:
	if global_position.y <= 48.0:
		is_moving_down = false
	elif global_position.y >= 320.0:
		is_moving_down = true
	
	if is_moving_down:
		velocity.y = -MOVING_SPEED
	else:
		velocity.y = MOVING_SPEED
	
	move_and_slide()
