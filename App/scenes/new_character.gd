extends Control

@export var template_container : Container
@export var template_button : PackedScene
@export var sheet : PackedScene

func _ready():
	var dir = DirAccess.open("user://templates")
	for file in dir.get_files():
		if file.contains(".template"):
			var new_button = template_button.instantiate()
			new_button.template_name = file.erase(file.length() - 9, file.length() - 1).capitalize()
			template_container.add_child(new_button)

func _on_template_selected(template_name : String):
	var dir = DirAccess.open("user://templates")
	var file_found = dir.file_exists("user://templates/" + template_name.to_snake_case() + ".template")
	if file_found:
		var new_sheet = sheet.instantiate()
		new_sheet.load_template("user://templates/" + template_name.to_snake_case() + ".template")
		get_tree().root.add_child(new_sheet)
		queue_free()

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/load_menu.tscn")
