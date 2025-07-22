extends Node

var scene_paths: Array
var curr_scene_index := -1
var level_directory := "res://scenes/levels/student_levels/"
var name_label: Label

func _ready() -> void:
	scene_paths = Array(ResourceLoader.list_directory(level_directory))
	scene_paths.shuffle()

func set_name_label(label: Label) -> void:
	name_label = label
	name_label.set_label(format_string(scene_paths[curr_scene_index])) #TEMP!!

func load_scene_deferred() -> void:
	curr_scene_index = (curr_scene_index) % scene_paths.size()
	var scene := ResourceLoader.load(level_directory + scene_paths[curr_scene_index])
	get_tree().change_scene_to_packed(scene)

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
