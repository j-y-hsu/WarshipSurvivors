extends Node2D

@export var max_speed: float = 200.0
@export var acceleration: float = 50
@export var decceleration: float = 50
@export var max_rotation_speed: float = 1
@export var rotation_acceleration: float = 0.007

var speed_interval: float = max_speed / 4.0
var min_speed: float = -1 * speed_interval
var current_speed: float = 0.0
var current_speed_interval: float = 0.0
var rotation_direction: float = 0
var current_rotation_speed: float = 0.0

#func _process(delta):
#	if current_speed < current_speed_interval:
#		current_speed = min(current_speed + (acceleration * delta), current_speed_interval)
#	if current_speed > current_speed_interval:
#		current_speed = max(current_speed - (decceleration * delta), current_speed_interval)


func adjust_bearing(delta, turning, direction):
	if turning:
		current_rotation_speed = clamp(current_rotation_speed + (direction * rotation_acceleration * delta), -max_rotation_speed, max_rotation_speed)
	else:
		if current_rotation_speed > 0:
			current_rotation_speed = max(current_rotation_speed - (rotation_acceleration * delta), 0)
		if current_rotation_speed < 0:
			current_rotation_speed = min(current_rotation_speed + (rotation_acceleration * delta), 0)


func adjust_speed_interval(direction):
	current_speed_interval = clamp(current_speed_interval + (direction * speed_interval), min_speed, max_speed)

func adjust_speed(delta):
	if current_speed < current_speed_interval:
		current_speed = min(current_speed + (acceleration * delta), current_speed_interval)
	if current_speed > current_speed_interval:
		current_speed = max(current_speed - (decceleration * delta), current_speed_interval)
#	if Input.is_action_just_pressed("up"):
#		current_speed_interval = min(current_speed_interval + speed_interval, max_speed)
#	if Input.is_action_just_pressed("down"):
#		current_speed_interval = max(current_speed_interval - speed_interval, min_speed)
