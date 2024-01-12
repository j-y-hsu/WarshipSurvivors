extends CharacterBody2D

signal gun_fired(muzzle_transforms: Array)

@export var bullet: PackedScene

@onready var reload_timer: Timer = $ReloadTimer
@onready var muzzle_A = $MuzzleA
@onready var muzzle_B = $MuzzleB
var ready_to_fire: bool = true


func _ready():
	$Shoot.modulate = 0
	reload_timer.timeout.connect(on_reload_timer_timeout)


func _draw():
	draw_dashed_line(Vector2.ZERO, Vector2.RIGHT * 600, Color.RED, 1.0);


func rotate_gun(angle_to_target, rotation_rate, min_firing_angle, max_firing_angle, rotation_direction):
	rotation = clamp(rotation + (rotation_direction * min(abs(rotation_rate), abs(angle_to_target))), min_firing_angle, max_firing_angle)


func fire_gun():
	if ready_to_fire:
#		var a = bullet.instantiate()
#		var b = bullet.instantiate()
		play_animation()
		gun_fired.emit([muzzle_A.global_transform, muzzle_B.global_transform])
#		owner.add_child(a)
#		owner.add_child(b)
#		print($MuzzleA.transform)
#		a.global_transform = $MuzzleA.global_transform
#		b.global_transform = $MuzzleB.global_transform
		ready_to_fire = false
		reload_timer.start()


func play_animation():
	$Shoot/AnimationPlayer.play("fire")


func on_reload_timer_timeout():
	ready_to_fire = true
