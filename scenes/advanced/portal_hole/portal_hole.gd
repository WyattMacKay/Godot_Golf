extends Hole

@export var connected_hole: Hole
@export var color: Color = Color("FFA500")
@export var exit_speed := 20 
@export_group("Don't Touch!")
@export var own_sprite: Sprite2D

func _ready() -> void:
	if !connected_hole:
		push_error("No hole connected to " + self.to_string())
		get_tree().quit()
	own_sprite.modulate = color
	timer.connect("timeout", ball_sank)

func ball_sank() -> void:
	if ball:
		#var temp_vect = connected_hole.position
		#var direction = (temp_vect - Vector2(temp_vect.x, temp_vect.y + 1)).normalized()
		ball.linear_velocity = Vector2.UP.rotated(connected_hole.rotation) * exit_speed
		ball.global_position = connected_hole.global_position
		connected_hole.ball_exited()

func ball_exited() -> void:
	var t := Timer.new()
	t.wait_time = 0.5
	t.connect("timeout", reactivate)
	t.process_mode = Node.PROCESS_MODE_ALWAYS
	t.one_shot = true
	self.add_child(t)
	t.start()
	self.process_mode = Node.PROCESS_MODE_DISABLED


func reactivate() -> void:
	self.process_mode = Node.PROCESS_MODE_INHERIT
