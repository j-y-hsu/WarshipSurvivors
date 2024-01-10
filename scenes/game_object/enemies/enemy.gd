extends CharacterBody2D

const MAX_SPEED: float = 100
var current_speed: float = 40
var rotation_speed: float = 2


func _process(delta):
	var target_velocity = transform.x * MAX_SPEED
	velocity = target_velocity
	move_and_slide()
	
	var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player == null:
		return
	
	var angle_to_target = get_angle_to(player.global_position)
#	print("player position: ", player.global_position)
#	print("to target: ", rad_to_deg(angle_to_target))
#	print("global rotation: ", rad_to_deg(rotation))
	if !is_zero_approx(angle_to_target):
		global_rotation = global_rotation + (sign(angle_to_target) * min(abs(angle_to_target), rotation_speed)) * delta
