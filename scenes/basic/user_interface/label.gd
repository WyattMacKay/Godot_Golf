extends Label

@export var par := 3
@export var score := 0

func _ready() -> void:
	Global.set_label(self)

func _on_ball_fired() -> void:
	score += 1
	set_label()

func set_label() -> void:
	text = "Par: %d\nShots: %d" % [par,score]
