extends PathFollow2D

func _physics_process(delta: float) -> void:
	progress_ratio += 1 * delta
