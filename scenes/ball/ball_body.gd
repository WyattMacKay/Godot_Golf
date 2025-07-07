extends RigidBody2D

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("mouse_click"):
		print("clicked")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released("mouse_click"):
		var difference: Vector2 = self.global_position - get_viewport().get_mouse_position()
		if difference.length() <= %CircleCollision.shape.radius:
			print("cancelled")
		else:
			print("released")
