extends Node2D

var ball: RigidBody2D = null

@export var outer_pull := 250
@export var inner_pull := 200
@export var min_distance := 10

var in_inner_pull_range := false

func _physics_process(delta: float) -> void:
	if ball:
		var dir = self.global_position - ball.global_position
		#var len = dir.length()
		#if ball.linear_velocity.length() > ball.max_power/5:		#Just doesn't feel good
		if dir.length() > 1:
			if in_inner_pull_range:
				if ball.linear_velocity.length() < min_distance:
					ball.linear_velocity = ball.linear_velocity.move_toward(dir, inner_pull * delta * 10)
					
				#ball.apply_force(dir.normalized() * inner_pull) #apply force at 1/distance
				else:
					ball.linear_velocity = ball.linear_velocity.move_toward(Vector2.ZERO, inner_pull * delta)
					print(dir.length())
			else:
				ball.apply_force(dir.normalized() * outer_pull)


func _on_outer_hole_body_entered(body: Node2D) -> void:
	ball = body


func _on_outer_hole_body_exited(_body: Node2D) -> void:
	ball = null


func _on_inner_hole_body_entered(_body: Node2D) -> void:
	in_inner_pull_range = true


func _on_inner_hole_body_exited(_body: Node2D) -> void:
	in_inner_pull_range = false
