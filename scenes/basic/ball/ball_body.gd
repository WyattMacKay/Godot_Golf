extends RigidBody2D

@export var ground_tiles: TileMapLayer
@export var max_power := 250
var line: Line2D = null
var clicked := false
signal fired

func _ready() -> void:
	Global.set_ball(self)


func _process(_delta: float) -> void:
	if clicked:
		update_line()


func _physics_process(delta: float) -> void:
	apply_tile_effect(delta)
	%BallNode.rotate(get_rot(delta))


func apply_tile_effect(delta: float) -> void:
	var tile_data := get_current_tile()
	if tile_data.get_custom_data("is_water"):
		apply_water_effect()
	var friction: float = tile_data.get_custom_data("friction")
	apply_friction(friction, delta)


func apply_friction(friction: float, delta: float) -> void:
	linear_velocity = linear_velocity.move_toward(Vector2.ZERO, friction * delta * 100)


func apply_water_effect() -> void:
	Global.reset_ball()


func update_line() -> void:
	line.remove_point(1)
	line.add_point(self.position - get_mouse_distance())
	var difference := get_mouse_distance()
	var red_value := 1-difference.length()/max_power
	line.default_color = Color(1, red_value, red_value, 1.0)
	vibrate(difference)


func vibrate(difference: Vector2) -> void:
	var min_vibe := max_power*0.75
	var vibe_radius := difference.length() / min_vibe
	if(vibe_radius < 1): 
		line.position = Vector2.ZERO
		return
	var angle = randf() * 2 * PI
	var radius = randf() * vibe_radius
	var offset = Vector2(cos(angle), sin(angle)) * radius
	line.position = offset


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("mouse_click"):
		clicked = true
		line = Line2D.new()
		self.get_parent().add_child(line)
		line.add_point(self.global_position)
		line.add_point(Vector2.ZERO)
		line.antialiased = true


func _unhandled_input(_event: InputEvent) -> void:
	var difference := get_mouse_distance()
	if Input.is_action_just_released("mouse_click") and clicked:
		clicked = false
		if difference.length() > %CircleCollision.shape.radius:
			fire(difference)
		line.free()
		line = null


func fire(difference: Vector2) -> void:
	$BallNode/Sprite.self_modulate = Color.LAVENDER
	input_pickable = false
	var modifier := 1.0
	if get_current_tile().get_custom_data("friction") > 0.5:
		modifier = 0.5
	apply_impulse(difference * difference.length() / 50 * modifier)
	fired.emit()


func _on_sleeping_state_changed() -> void:
	if sleeping:
		$BallNode/Sprite.self_modulate = Color.WHITE
		input_pickable = true


func get_rot(delta: float) -> float:
	if(linear_velocity.x == 0): return 0
	var r = $CircleCollision.shape.radius
	var rot = (linear_velocity.x / r) * delta
	return rot * 2


func get_mouse_distance() -> Vector2:
	var distance := -get_local_mouse_position()
	if distance.length() < max_power:
		return distance
	return distance.normalized() * max_power


func get_current_tile() -> TileData:
	var tile_pos := ground_tiles.local_to_map(global_position)
	var tile_data := ground_tiles.get_cell_tile_data(tile_pos)
	return tile_data
