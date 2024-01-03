extends CharacterBody2D

@export var placement: String = "A"
@export var rotation_speed: float = 1
@export var min_firing_angle: float = 0
@export var max_firing_angle: float = 180

var rotation_flip: float = 0
var rad_min_firing_angle
var rad_max_firing_angle

func _ready():
	$Node2D.modulate = 0
	rotation_flip = deg_to_rad((max_firing_angle - min_firing_angle) / 2)
	rad_min_firing_angle = deg_to_rad(min_firing_angle)
	rad_max_firing_angle = deg_to_rad(max_firing_angle)


func _process(delta):
	
	var angle_to_mouse = global_position.angle_to_point(get_global_mouse_position())
	var angle_to_rotate = get_angle_to(get_global_mouse_position())
	var target_rotation = rad_to_deg(rotation + angle_to_rotate)
	var rotation_rate = rotation_speed * delta
#	if placement == "A":
#		print(placement + " angle to mouse: ", angle_to_mouse)
#		print("angle to rotate: ", angle_to_rotate)
#		print(placement + " global rotation: ", global_rotation)
#		print(placement + " rotation: ", rotation)
#		print(rotation_flip)
#	var target_rotation = rotation
#	if rotation > angle_to_rotate:
#		target_rotation = max(rotation - (rotation_speed * delta), angle_to_rotate)
#		rotate(target_rotation)
#	elif rotation < angle_to_rotate:
#		target_rotation = min(rotation + (rotation_speed * delta), angle_to_rotate)
#		rotate(target_rotation)
	
	var mod_rotation = fmod(target_rotation, 360)
#	if (mod_rotation > min_firing_angle && mod_rotation < max_firing_angle):
	if angle_to_rotate < 0:
#		rotation = max(rotation - (rotation_rate), deg_to_rad(min_firing_angle))
		rotate_port(rotation_rate)
	elif angle_to_rotate > 0:
#		rotation = min(rotation + (rotation_rate), deg_to_rad(max_firing_angle))
		rotate_starboard(rotation_rate)


func rotate_port(rotation_rate):
	rotation = max(rotation - rotation_rate, rad_min_firing_angle)


func rotate_starboard(rotation_rate):
	rotation = min(rotation + rotation_rate, rad_max_firing_angle)


func rotate_gun(angle_to_rotate):
	rotate(angle_to_rotate)
	if Input.is_action_just_pressed("left_click"):
		play_fire()


func play_fire():
	$Node2D/AnimationPlayer.play("fire")
