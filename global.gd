extends Node

var ball: RigidBody2D = null
var ball_start_pos: Vector2 = Vector2.ZERO
var score_label: Label = null 

func set_label(l: Label) -> void:
	score_label = l
	if ball:
		initialize_label()

func set_ball(b: Node2D) -> void:
	ball = b
	ball_start_pos = b.global_position
	if score_label:
		initialize_label()

func initialize_label() -> void:
	ball.fired.connect(score_label._on_ball_fired.bind())
	score_label.set_label()

func reload():
	get_tree().reload_current_scene()

func reset_ball():
	ball.global_position = ball_start_pos
	ball.linear_velocity = Vector2.ZERO
