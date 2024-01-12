extends CharacterBody2D

@onready var ship: Node2D = $Ship

@export var bullet: PackedScene

func _ready():
	ship.gun_fired.connect(on_gun_fired)


func _process(delta):
	adjust_bearing(delta)
	adjust_speed(delta)
	if Input.is_action_just_pressed("left_click"):
		ship.fire_guns()


func adjust_speed(delta):
	if Input.is_action_just_pressed("up"):
		ship.adjust_speed_interval(1)
	elif Input.is_action_just_pressed("down"):
		ship.adjust_speed_interval(-1)
	
	ship.adjust_speed(delta)
	var target_velocity = transform.x * ship.current_speed
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


func on_gun_fired(muzzle_transforms):
	for muzzle_transform in muzzle_transforms:
		var b = bullet.instantiate()
		if b == null:
			return

		owner.add_child(b)
		b.transform = muzzle_transform
