extends Node

var scene_paths: Array
var curr_scene_index := -1
var level_directory := "res://scenes/levels/student_levels/"

func _ready() -> void:
	scene_paths = Array(ResourceLoader.list_directory(level_directory))
	scene_paths.shuffle()

func load_scene_deferred() -> void:
	curr_scene_index = (curr_scene_index) % scene_paths.size()
	var scene := ResourceLoader.load(level_directory + scene_paths[curr_scene_index])
	get_tree().change_scene_to_packed(scene)
	print(format_string(scene_paths[curr_scene_index]))

func load_next_scene() -> void:
	curr_scene_index += 1
	call_deferred("load_scene_deferred")

func load_prev_scene() -> void:
	curr_scene_index -= 1
	call_deferred("load_scene_deferred")

func format_string(input: String) -> String:
	input = input.get_basename()
	var words = input.split("_")  
	for i in words.size():
		words[i] = words[i].capitalize()  
	return " ".join(words)  

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_right"):
		load_next_scene()
	elif Input.is_action_just_pressed("ui_left"):
		load_prev_scene()
