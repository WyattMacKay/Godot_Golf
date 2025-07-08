extends Node

var ball: RigidBody2D = null
var score_label: Label = null 

func set_label(l: Label) -> void:
	score_label = l
	if ball:
		initialize_label()

func set_ball(b: Node2D) -> void:
	ball = b
	if score_label:
		initialize_label()

func initialize_label() -> void:
	ball.fired.connect(score_label._on_ball_fired.bind())
	score_label.set_label()
