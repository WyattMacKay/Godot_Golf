extends CanvasLayer

@export var par := 3
@export_group("Don't Touch!")
@export var label: Label
@export var menu: Control

func _ready() -> void:
	self.visible = true
	label.par = par
	Global.set_ui(self)
	hide_menu()

func show_menu() -> void:
	menu.visible = true
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(menu, "position", Vector2(menu.position.x, 100), 0.25)

func hide_menu() -> void:
	menu.visible = false
	menu.position.y = -800

func get_menu_label() -> Label:
	return menu.label
