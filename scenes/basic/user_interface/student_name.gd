extends Label

func _ready() -> void:
	LevelChanger.set_name_label(self)

func set_label(string: String):
	text = string
