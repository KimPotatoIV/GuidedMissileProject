extends CharacterBody2D

##################################################
const FIRE_BALL: PackedScene = \
preload("res://scenes/fire_ball/fire_ball.tscn")

const MOVING_SPEED = 75.0

##################################################
func _physics_process(delta: float) -> void:
	var x_direction: float = Input.get_axis("ui_left", "ui_right")
	if x_direction:
		velocity.x = x_direction * MOVING_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVING_SPEED)
	
	var y_direction: float = Input.get_axis("ui_up", "ui_down")
	if y_direction:
		velocity.y = y_direction * MOVING_SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, MOVING_SPEED)

	move_and_slide()

##################################################
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_fire_ball()

##################################################
func _fire_ball() -> void:
	var fire_ball_instance = FIRE_BALL.instantiate()
	fire_ball_instance.global_position = global_position
	get_parent().add_child(fire_ball_instance)
