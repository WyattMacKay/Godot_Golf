extends Node

var ball: RigidBody2D = null
var ball_start_pos: Vector2 = Vector2.ZERO
var ui: CanvasLayer = null
var score_label: Label = null 
var menu: Control = null

func set_ui(ui_in: CanvasLayer) -> void:
	ui = ui_in
	set_label(ui.label)
	menu = ui.menu

func set_label(l: Label) -> void:
	score_label = l
	if ball:
		initialize_label()

func set_ball(b: Node2D) -> void:
	ball = b
	set_ball_position()
	if score_label:
		initialize_label()
	ball.fired.connect(set_ball_position.bind())

func initialize_label() -> void:
	ball.fired.connect(score_label._on_ball_fired.bind())
	score_label.set_label()

func win() -> void:
	var menu_label: Label = menu.label
	var score: int = score_label.score
	var par: int = score_label.par
	var golf_term: String
	match score - par:
		-4: golf_term = "!!CONDOR!!"
		-3: golf_term = "ALBATROSS!!!"
		-2: golf_term = "EAGLE!!"
		-1: golf_term = "BIRDIE!"
		0: golf_term = "PAR"
		1: golf_term = "BOGEY"
		2: golf_term = "DOUBLE BOGEY"
		3: golf_term = "TRIPLE BOGEY"
		_: golf_term = str(score - par) + " strokes"
	golf_term += "\nPAR: %d\nYOUR SCORE:%d" % [par, score]
	menu_label.text = golf_term
	ui.show_menu()

func reload() -> void:
	get_tree().reload_current_scene()

func reset_ball() -> void:
	ball.global_position = ball_start_pos
	ball.linear_velocity = Vector2.ZERO

func set_ball_position() -> void:
	ball_start_pos = ball.global_position
