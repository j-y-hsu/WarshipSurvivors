extends CharacterBody2D

const MAX_SPEED = 200.0
const SPEED_INTERVAL = MAX_SPEED / 4.0
const MIN_SPEED = -1 * SPEED_INTERVAL
const ACCELERATION = 50
const DECCELERATION = 75
const MAX_ROTATION_SPEED = 1
const ROTATION_ACCELERATION = 0.007

var current_speed: float = 0.0
var current_speed_interval: float = 0.0
var rotation_direction = 0
var current_rotation_speed = 0.0


func _process(delta):
	move_player(delta)


func move_player(delta):
	get_input()
	adjust_speed(delta)
	if current_speed != 0:
		var target_rotation = current_rotation_speed
		global_rotation += target_rotation * delta
	
	var target_velocity = transform.y * -current_speed
	velocity = target_velocity
	move_and_slide()


func get_input():
	if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
		rotation_direction = Input.get_axis("left", "right")
		if rotation_direction == 1:
			current_rotation_speed = min(current_rotation_speed + ROTATION_ACCELERATION, MAX_ROTATION_SPEED)
		if rotation_direction == -1:
			current_rotation_speed = max(current_rotation_speed - ROTATION_ACCELERATION, -MAX_ROTATION_SPEED)
	else:
		if rotation_direction == 1:
			current_rotation_speed = max(current_rotation_speed - ROTATION_ACCELERATION, 0)
		if rotation_direction == -1:
			current_rotation_speed = min(current_rotation_speed + ROTATION_ACCELERATION, 0)
		
	if Input.is_action_just_pressed("up"):
		current_speed_interval = min(current_speed_interval + SPEED_INTERVAL, MAX_SPEED)
	if Input.is_action_just_pressed("down"):
		current_speed_interval = max(current_speed_interval - SPEED_INTERVAL, MIN_SPEED)


func adjust_speed(delta):
	if current_speed < current_speed_interval:
		current_speed = min(current_speed + (ACCELERATION * delta), current_speed_interval)
	if current_speed > current_speed_interval:
		current_speed = max(current_speed - (DECCELERATION * delta), current_speed_interval)
