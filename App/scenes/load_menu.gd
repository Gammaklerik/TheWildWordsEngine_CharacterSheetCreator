extends Control

func _ready():
	var dir = DirAccess.open("user://")
	if !dir.dir_exists("user://characters"):
		dir.make_dir_recursive("user://characters")
	if !dir.dir_exists("user://templates"):
		dir.make_dir_recursive("user://templates")

func _on_load_character_pressed():
	get_tree().change_scene_to_file("res://scenes/load_character.tscn")

func _on_new_character_pressed():
	get_tree().change_scene_to_file("res://scenes/new_character.tscn")

func _on_new_template_pressed():
	get_tree().change_scene_to_file("res://scenes/blank_sheet.tscn")

func _on_quit_app_pressed():
	get_tree().quit()
