extends Node2D

var ball: RigidBody2D = null

@export var outer_pull := 250
@export var inner_pull := 200
@export var min_velocity := 10
@export var timer: Timer

var in_inner_pull_range := false
var putt_sank := false

func _ready() -> void:
	timer.connect("timeout", ball_sank)

func _physics_process(delta: float) -> void:
	if ball:
		var dir = self.global_position - ball.global_position
		if putt_sank:
			ball.position = ball.position.move_toward(self.global_position, 50 * delta)
		
		elif dir.length() > 1:
			if in_inner_pull_range:
				if !putt_sank and ball.linear_velocity.length() < min_velocity:
					putt_sank = true
					timer.start()
				else:
					ball.linear_velocity = ball.linear_velocity.move_toward(Vector2.ZERO, inner_pull * delta)
			else:
				ball.apply_force(dir.normalized() * outer_pull)


func ball_sank() -> void:
	print("You did it!")
	Global.reload()


func _on_outer_hole_body_entered(body: Node2D) -> void:
	ball = body


func _on_outer_hole_body_exited(_body: Node2D) -> void:
	ball = null
	putt_sank = false


func _on_inner_hole_body_entered(_body: Node2D) -> void:
	in_inner_pull_range = true


func _on_inner_hole_body_exited(body: Node2D) -> void:
	in_inner_pull_range = false
	body.linear_velocity *= 0.5
