extends CharacterBody2D

@onready var ship: Node2D = $Ship


func _process(delta):
	adjust_bearing(delta)
	adjust_speed(delta)


func adjust_speed(delta):
	if Input.is_action_just_pressed("up"):
		ship.adjust_speed_interval(1)
	elif Input.is_action_just_pressed("down"):
		ship.adjust_speed_interval(-1)
	
	ship.adjust_speed(delta)
	var target_velocity = transform.y * -ship.current_speed
	velocity = target_velocity
	move_and_slide()	

func adjust_bearing(delta):
	var turning = false
	var rotation_direction = 0
	
	if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
		rotation_direction = Input.get_axis("left", "right")
		turning = true
	
	ship.adjust_bearing(delta, turning, rotation_direction)
	if ship.current_speed != 0:
		var target_rotation = ship.current_rotation_speed
		global_rotation += target_rotation * delta	
