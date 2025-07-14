extends CanvasLayer

@export var par := 3
@export_group("Don't Touch!")
@export var label := Label

func _ready() -> void:
	label.par = par
