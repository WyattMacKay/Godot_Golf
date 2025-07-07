extends RigidBody2D

@onready var tilemap: TileMapLayer = self.get_parent().get_child(0)
@onready var clicked = false

func _physics_process(delta):
	var tile_pos := tilemap.local_to_map(global_position)
	var tile_data := tilemap.get_cell_tile_data(tile_pos)
	var friction: float = tile_data.get_custom_data("Friction")

	linear_velocity = linear_velocity.move_toward(Vector2.ZERO, friction * delta * 100)	#apply friction

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("mouse_click"):
		clicked = true
		print("clicked")

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("mouse_click") and clicked:
		clicked = false
		var difference: Vector2 = self.global_position - get_viewport().get_mouse_position()
		if difference.length() <= %CircleCollision.shape.radius:
			print("cancelled")
		else:
			fire(difference)
			print("released")
	
	if Input.is_key_pressed(KEY_E):
		print(tilemap)

func fire(difference: Vector2):
	apply_impulse(difference)
