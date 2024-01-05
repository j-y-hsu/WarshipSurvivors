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
	var angle_to_mouse = turret.position.angle_to_point(turret.get_local_mouse_position())
	var rotation_rate = turret_speed * delta
	turret.rotate_gun(angle_to_mouse, rotation_rate, rad_min_firing_angle, rad_max_firing_angle)
	
