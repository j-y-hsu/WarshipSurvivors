extends Node2D

signal gun_fired(muzzle_transforms: Array)

@export var max_speed: float = 200.0
@export var acceleration: float = 50
@export var decceleration: float = 50
@export var max_rotation_speed: float = 1
@export var rotation_acceleration: float = 0.007

var turretWells: Array
var speed_interval: float = max_speed / 4.0
var min_speed: float = -1 * speed_interval
var current_speed: float = 0.0
var current_speed_interval: float = 0.0
var rotation_direction: float = 0
var current_rotation_speed: float = 0.0


func _ready():
	turretWells = find_children("TurretWell*")
	turretWells.reverse()
	for turretWell in turretWells:
		turretWell.turret.gun_fired.connect(on_gun_fired)


func fire_guns():
	if turretWells.size() == 0:
		return
	
	for turretWell in turretWells:
		turretWell.fire_gun()


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


func on_gun_fired(muzzle_transforms):
	gun_fired.emit(muzzle_transforms)
