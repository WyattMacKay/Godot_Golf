extends Path2D

@export var shape: TileMapLayer
@export var speed := 1.0
@export_group("Don't Touch")
@export var path_follow: PathFollow2D

func _ready() -> void:
	shape.reparent(path_follow)

func _physics_process(delta: float) -> void:
	path_follow.progress_ratio += speed * 0.25 * delta
