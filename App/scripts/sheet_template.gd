extends Node

@onready var character_sheet : Control = get_parent()

func save(filename : String):
	var edges : Array[String]
	var skills : Array[String]
	var languages : Array[String]
	
	for edge in character_sheet.edges_container.get_children():
		edges.append(edge.get_child(0).text)
	for skill in character_sheet.skills_container.get_children():
		skills.append(skill.get_child(0).text)
	for language in character_sheet.languages_container.get_children():
		languages.append(language.get_child(0).text)	
	
	var save_dict : Dictionary = {
		"template_name" : filename.erase(filename.length() - 9, filename.length() - 1).capitalize(),
		"to_roll_text" : character_sheet.to_roll_text_edit.text,
		"results_text" : character_sheet.results_text_edit.text,
		"bloodline_rename" : character_sheet.bloodline_text_edit.text,
		"origin_rename" : character_sheet.origin_text_edit.text,
		"post_rename" : character_sheet.post_text_edit.text,
		"edges" : edges,
		"skills" : skills,
		"languages" : languages,
		"resource_01_rename" : character_sheet.resource_01_edit.text,
		"resource_02_rename" : character_sheet.resource_02_edit.text,
		"resource_03_rename" : character_sheet.resource_03_edit.text,
		"resource_04_rename" : character_sheet.resource_04_edit.text
	}
	return save_dict
