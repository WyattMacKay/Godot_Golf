extends Button

enum Direction {PREVIOUS, NEXT}
@export var direction: Direction

func _on_button_up() -> void:
	if direction == Direction.PREVIOUS:
		LevelChanger.load_prev_scene()
	else:
		LevelChanger.load_next_scene()
