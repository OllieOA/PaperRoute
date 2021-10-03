extends RigidBody2D

onready var back_wheel = get_parent().get_node("BackWheel")
var max_rotation_speed = 5

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	print()
	if back_wheel.angular_velocity > 2:
		var new_degrees = rotation_degrees + max_rotation_speed
		if new_degrees > 360:
			new_degrees = 5
		rotation_degrees = new_degrees
	elif back_wheel.angular_velocity < -2:
		var new_degrees = rotation_degrees - max_rotation_speed
		if new_degrees < 0:
			new_degrees = 355
		rotation_degrees = new_degrees
		
	
