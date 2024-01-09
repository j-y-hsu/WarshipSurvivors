extends CharacterBody2D

@export var placement: String = "A"
@export var rotation_speed: float = 2

func _ready():
	$Shoot.modulate = 0


func rotate_gun(angle_to_target, rotation_rate, min_firing_angle, max_firing_angle, rotation_direction):
	rotation = clamp(rotation + (rotation_direction * min(abs(rotation_rate), abs(angle_to_target))), min_firing_angle, max_firing_angle)
	if Input.is_action_just_pressed("left_click") && is_zero_approx(angle_to_target):
		play_animation()


func fire_gun():
	play_animation()


func play_animation():
	$Shoot/AnimationPlayer.play("fire")
