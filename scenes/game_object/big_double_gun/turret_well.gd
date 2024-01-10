extends Node2D

@onready var turret: Node2D = $ShipBigDoubleGun

@export var placement: String = "A"
@export var min_firing_angle: float = -90
@export var max_firing_angle: float = 90
@export var turret_speed: float = 2

var rad_min_firing_angle: float
var rad_max_firing_angle: float


func _ready():
	rad_min_firing_angle = deg_to_rad(min_firing_angle)
	rad_max_firing_angle = deg_to_rad(max_firing_angle)


func _process(delta):
	var angle = turret.position.angle_to_point(get_local_mouse_position())

	var angle_to_mouse = turret.position.angle_to_point(turret.get_local_mouse_position())
	var rotation_rate = turret_speed * delta
	var rotation_direction = 0

	if angle > rad_min_firing_angle && angle < rad_max_firing_angle:
		rotation_direction = sign(angle_to_mouse)
	else:
		rotation_direction = sign(angle)
		
	turret.rotate_gun(angle_to_mouse, rotation_rate, rad_min_firing_angle, rad_max_firing_angle, rotation_direction)

func fire_gun():
	var angle_to_mouse = turret.position.angle_to_point(turret.get_local_mouse_position())
	print (angle_to_mouse)
	if snappedf(angle_to_mouse, 0.01) == 0.0:
		turret.fire_gun()
