extends CharacterBody2D


func _ready():
	$Shoot.modulate = 0


func _draw():
	draw_dashed_line(Vector2.ZERO, Vector2.RIGHT * 300, Color.RED, 1.0);


func rotate_gun(angle_to_target, rotation_rate, min_firing_angle, max_firing_angle, rotation_direction):
	rotation = clamp(rotation + (rotation_direction * min(abs(rotation_rate), abs(angle_to_target))), min_firing_angle, max_firing_angle)


func fire_gun():
	play_animation()


func play_animation():
	$Shoot/AnimationPlayer.play("fire")
