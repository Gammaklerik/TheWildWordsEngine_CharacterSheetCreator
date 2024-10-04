extends Control

@export var template_container : Container
@export var character_button : PackedScene
@export var sheet : PackedScene

func _ready():
	var dir = DirAccess.open("user://characters")
	for file in dir.get_files():
		if file.contains(".char"):
			var new_button = character_button.instantiate()
			new_button.file_name = file.erase(file.length() - 5, file.length() - 1).capitalize()
			var character_file = FileAccess.open("user://characters/" + file, FileAccess.READ)
			var json_string = character_file.get_line()
		
			var json = JSON.new()
			json.parse(json_string)
			var data = json.get_data()
			new_button.template_name = data["sheet_template"].capitalize()
			template_container.add_child(new_button)

func _on_character_selected(file_name : String, template_name : String):
	var new_sheet
	var dir = DirAccess.open("user://templates")
	var template_file_found = dir.file_exists("user://templates/" + template_name.to_snake_case() + ".template")
	if template_file_found:
		new_sheet = sheet.instantiate()
		new_sheet.load_template("user://templates/" + template_name.to_snake_case() + ".template")
	
	var char_dir = DirAccess.open("user://characters")
	var character_file_found = char_dir.file_exists("user://characters/" + file_name.to_snake_case() + ".char")
	print("user://characters/" + file_name.to_snake_case() + ".char")
	if character_file_found:
		new_sheet.load_character("user://characters/" + file_name.to_snake_case() + ".char")
	else:
		print("UH OH")
	get_tree().root.add_child(new_sheet)
	queue_free()

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/load_menu.tscn")
