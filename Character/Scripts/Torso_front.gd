extends RigidBody2D

onready var frame = get_parent().get_parent()
onready var seat = get_parent().get_parent().get_node("Seat")

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var target_rotation = frame.global_rotation_degrees
	global_rotation_degrees += (target_rotation - global_rotation_degrees) * 0.1
	
	var target_position = seat.global_position
	global_position += (target_position - global_position) * 0.1
