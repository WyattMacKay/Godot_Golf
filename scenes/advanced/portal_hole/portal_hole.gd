extends Hole

@export var connected_hole: Hole
@export var color: Color = Color("FFA500")
@export_group("Don't Touch!")
@export var own_sprite: Sprite2D

func _ready() -> void:
	if !connected_hole:
		push_error("No hole connected to " + self.to_string())
		get_tree().quit()
	own_sprite.modulate = color

func ball_sank() -> void:
	pass
