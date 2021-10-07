extends Area2D


func _on_InvisibleGate_body_entered(body: Node) -> void:
	if "Character" in body.get_name():
		var curr_scene = "res://Levels/Level" + str(world_parameters.curr_level) + ".tscn"
		scene_transition.goto_scene(curr_scene)  # Replace with checkpoint
