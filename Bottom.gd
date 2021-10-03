extends Area2D


func _on_Bottom_body_entered(body: Node) -> void:
	if "Character" in body.get_name() or "Trailer" in body.get_name():
		get_tree().reload_current_scene()  # Replace with checkpoint
	else:
		body.queue_free()

