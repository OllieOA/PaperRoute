extends RigidBody2D


func _on_Newspaper_body_entered(body: Node) -> void:
	if body.is_in_group("ground"):
		queue_free()
