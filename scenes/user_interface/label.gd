extends Label

@export var par := 3
var shots := 0

func _ready() -> void:
	Global.set_label(self)

func _on_ball_fired() -> void:
	shots += 1
	set_label()

func set_label() -> void:
	text = "Par: %d\nShots: %d" % [par,shots]
