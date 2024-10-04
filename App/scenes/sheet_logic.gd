extends Control

var template : String

@export var edit_switch_button : Button
@export var sheet_template : Node
@export var sheet_data : Node
@export var save_dict : Dictionary
@onready var save_dialog : FileDialog = get_node("save_dialog")
var save_dir : String

@export var to_roll_text_edit : TextEdit
@export var results_text_edit : TextEdit
@export var bloodline_text_edit : TextEdit
@export var origin_text_edit : TextEdit
@export var post_text_edit : TextEdit
@export var resource_01_edit : TextEdit
@export var resource_02_edit : TextEdit
@export var resource_03_edit : TextEdit
@export var resource_04_edit : TextEdit
@onready var text_edits : Array[TextEdit] = [to_roll_text_edit, results_text_edit, bloodline_text_edit, origin_text_edit, post_text_edit, resource_01_edit, resource_02_edit, resource_03_edit, resource_04_edit]

@export var bloodline_underline : ColorRect
@export var origin_underline : ColorRect
@export var post_underline : ColorRect
@export var resource_01_underline : ColorRect
@export var resource_02_underline : ColorRect
@export var resource_03_underline : ColorRect
@export var resource_04_underline : ColorRect
@onready var underlines : Array[ColorRect] = [bloodline_underline, origin_underline, post_underline, resource_01_underline, resource_02_underline, resource_03_underline, resource_04_underline]

@export var edges_container : Container
@export var edge_template : PackedScene
@export var add_edges_button : Button

@export var skills_container : Container
@export var skill_template : PackedScene
@export var add_skills_button : Button

@export var languages_container : Container
@export var language_template : PackedScene
@export var add_languages_button : Button

@onready var add_buttons : Array[Button] = [add_edges_button, add_skills_button, add_languages_button]
@onready var containers : Array[Container] = [edges_container, skills_container, languages_container]

func _on_layout_edit_switch_toggled(toggled_on):
	if toggled_on:
		edit_switch_button.text = "Edit Sheet"
		for text in text_edits:
			text.editable = true
		for line in underlines:
			line.visible = true
		for button in add_buttons:
			button.visible = true
		for c in containers:
			for t in c.get_children():
				t.get_child(0).editable = true
				t.get_child(2).visible = true
				t.get_child(3).visible = true
	else:
		edit_switch_button.text = "Edit Layout"
		for text in text_edits:
			text.editable = false
		for line in underlines:
			line.visible = false
		for button in add_buttons:
			button.visible = false
		for c in containers:
			for t in c.get_children():
				t.get_child(0).editable = false
				t.get_child(2).visible = false
				t.get_child(3).visible = false

func _on_save_template_pressed():
	save_dialog.set_current_dir("user://templates")
	save_dir = save_dialog.current_dir
	save_dialog.title = "Save Template"
	save_dialog.current_file = "new_template.template"
	save_dialog.show()

func _on_save_character_pressed():
	save_dialog.set_current_dir("user://characters")
	save_dir = save_dialog.current_dir
	save_dialog.title = "Save Character"
	save_dialog.current_file = "new_character.char"
	save_dialog.show()

func _on_save_dialog_dir_selected(dir : String):
	save_dir = dir

func _on_save_dialog_confirmed():
	if save_dialog.title == "Save Template":
		save_dict = sheet_template.save(save_dialog.current_file)
	elif save_dialog.title == "Save Character":
		save_dict = sheet_data.save(save_dialog.current_file, template)
	var save_file : FileAccess = FileAccess.open(save_dir + "/" + save_dialog.current_file, FileAccess.WRITE)
	save_file.store_string(JSON.stringify(save_dict))
	save_file.close()

func load_template(file_path : String):
	var template_file = FileAccess.open(file_path, FileAccess.READ)
	while template_file.get_position() < template_file.get_length():
		var json_string = template_file.get_line()
		
		var json = JSON.new()
		json.parse(json_string)
		var data = json.get_data()
		
		template = data["template_name"]
		to_roll_text_edit.text = data["to_roll_text"]
		results_text_edit.text = data["results_text"]
		bloodline_text_edit.text = data["bloodline_rename"]
		origin_text_edit.text = data["origin_rename"]
		post_text_edit.text = data["post_rename"]
		resource_01_edit.text = data["resource_01_rename"]
		resource_02_edit.text = data["resource_02_rename"]
		resource_03_edit.text = data["resource_03_rename"]
		resource_04_edit.text = data["resource_04_rename"]
		for edge in data["edges"]:
			var new_edge = edge_template.instantiate()
			new_edge.get_child(0).text = edge
			edges_container.add_child(new_edge)
		for skill in data["skills"]:
			var new_skill = skill_template.instantiate()
			new_skill.get_child(0).text = skill
			skills_container.add_child(new_skill)
		for language in data["languages"]:
			var new_language = language_template.instantiate()
			new_language.get_child(0).text = language
			languages_container.add_child(new_language)

func load_character(file_path : String):
	var character_file = FileAccess.open(file_path, FileAccess.READ)
	while character_file.get_position() < character_file.get_length():
		var json_string = character_file.get_line()
		
		var json = JSON.new()
		json.parse(json_string)
		var data = json.get_data()
	
		get_node("character_sheet/sheet_container/section01/background/background_items/name/input").text = data["pc_name"]
		get_node("character_sheet/sheet_container/section01/background/background_items/player/input").text = data["player_name"]
		get_node("character_sheet/sheet_container/section01/background/background_items/bloodline/input").text = data["bloodline"]
		get_node("character_sheet/sheet_container/section01/background/background_items/origin/input").text = data["origin"]
		get_node("character_sheet/sheet_container/section01/background/background_items/post/input").text = data["post"]
		get_node("character_sheet/sheet_container/section01/milestones/container/major_milestones/input").text = data["major_milestones"]
		get_node("character_sheet/sheet_container/section01/milestones/container/minor_milestones/input").text = data["minor_milestones"]
		get_node("character_sheet/sheet_container/section01/drives/input").text = data["drives"]
		for mire in data["mires"]:
			var new_mire = load("res://templates/mire.tscn").instantiate()
			new_mire.get_child(2).text = mire["mire_text"]
			new_mire.get_child(3).get_child(0).track_idx = mire["mark_01"]
			new_mire.get_child(3).get_child(1).track_idx = mire["mark_02"]
			get_node("character_sheet/sheet_container/section01/mires/mires_container").add_child(new_mire)
		var edge_idx : int = 0
		for edge in data["edges"]:
			edges_container.get_child(edge_idx).get_child(1).button_pressed = edge
			edge_idx += 1
		var skill_idx : int = 0
		for skill in data["skills"]:
			for rank in skill:
				skills_container.get_child(skill_idx).get_child(1).get_child(rank).button_pressed = true
			skill_idx += 1
		var language_idx : int = 0
		for language in data["languages"]:
			for rank in language:
				languages_container.get_child(language_idx).get_child(1).get_child(rank).button_pressed = true
			language_idx += 1
		get_node("character_sheet/sheet_container/section02/resources/resources_container/resource01/input").text = data["resource_01"]
		get_node("character_sheet/sheet_container/section02/resources/resources_container/resource02/input").text = data["resource_02"]
		get_node("character_sheet/sheet_container/section02/resources/resources_container/resource03/input").text = data["resource_03"]
		get_node("character_sheet/sheet_container/section02/resources/resources_container/resource04/input").text = data["resource_04"]
		for aspect in data["aspects"]:
			var new_aspect = load("res://templates/aspect.tscn").instantiate()
			new_aspect.get_child(1).text = aspect["aspect_name"]
			new_aspect.get_child(2).text = aspect["aspect_description"]
			new_aspect.get_child(3).selected = aspect["aspect_type"]
			if aspect["track_marks"].size() > 1:
				var i : int = 1
				while i <= aspect["track_marks"].size() - 1:
					new_aspect.get_child(4).add_child(load("res://buttons/track_marker.tscn").instantiate())
					i += 1
			var track_num : int = 0
			for track in aspect["track_marks"]:
				new_aspect.get_child(4).get_child(track_num).track_idx = track
				track_num += 1
			get_node("character_sheet/sheet_container/section03/aspects/aspects_container").add_child(new_aspect)
		for temp_track in data["temporary_tracks"]:
			var new_track = load("res://templates/temporary_track.tscn").instantiate()
			new_track.get_child(1).text = temp_track["track_name"]
			new_track.get_child(2).text = temp_track["track_description"]
			new_track.get_child(3).selected = temp_track["track_type"]
			if temp_track["track_marks"].size() > 1:
				var i : int = 1
				while i <= temp_track["track_marks"].size() - 1:
					new_track.get_child(4).add_child(load("res://buttons/track_marker.tscn").instantiate())
					i += 1
			var track_num : int = 0
			for track in temp_track["track_marks"]:
				new_track.get_child(4).get_child(track_num).track_idx = track
				track_num += 1
			get_node("character_sheet/sheet_container/section03/temporary_tracks/temporary_tracks_container").add_child(new_track)
