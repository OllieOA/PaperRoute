extends RigidBody2D


onready var frame = get_parent().get_parent()

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var target_rotation = frame.global_rotation_degrees
	global_rotation_degrees += (target_rotation - global_rotation_degrees) * 0.05
