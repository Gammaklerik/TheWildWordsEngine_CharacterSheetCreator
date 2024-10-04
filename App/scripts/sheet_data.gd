extends Node

@onready var character_sheet : Control = get_parent()

func save(filename : String, template : String):
	var mires : Array[Dictionary]
	var edges : Array[bool]
	var skills : Array[int]
	var languages : Array[int]
	var resource_01 : String
	var resource_02 : String
	var resource_03 : String
	var resource_04 : String
	var aspects : Array[Dictionary]
	var temporary_tracks : Array[Dictionary]
	
	for mire in character_sheet.get_node("character_sheet/sheet_container/section01/mires/mires_container").get_children():
		mires.append({"mire_text" : mire.get_child(2).text, "mark_01" : mire.get_child(3).get_child(0).track_idx, "mark_02" : mire.get_child(3).get_child(1).track_idx})
	for edge in character_sheet.edges_container.get_children():
		edges.append(edge.get_child(1).button_pressed)
		pass
	for skill in character_sheet.skills_container.get_children():
		var skill_rank : int
		for rank in skill.get_child(1).get_children():
			if rank.button_pressed:
				skill_rank += 1
		skills.append(skill_rank)
	for language in character_sheet.languages_container.get_children():
		var language_rank : int
		for rank in language.get_child(1).get_children():
			if rank.button_pressed:
				language_rank += 1
		languages.append(language_rank)
	for aspect in character_sheet.get_node("character_sheet/sheet_container/section03/aspects/aspects_container").get_children():
		var track_marks : Array[int]
		for marker in aspect.get_child(4).get_children():
			track_marks.append(marker.track_idx)
		aspects.append({
			"aspect_name" : aspect.get_child(1).text,
			"aspect_type" : aspect.get_child(3).selected,
			"track_marks" : track_marks,
			"aspect_description" : aspect.get_child(2).text
		})
	for temp_track in character_sheet.get_node("character_sheet/sheet_container/section03/temporary_tracks/temporary_tracks_container").get_children():
		var track_marks : Array[int]
		for marker in temp_track.get_child(4).get_children():
			track_marks.append(marker.track_idx)
		temporary_tracks.append({
			"track_name" : temp_track.get_child(1).text,
			"track_type" : temp_track.get_child(3).selected,
			"track_marks" : track_marks,
			"track_description" : temp_track.get_child(2).text
		})
	
	var save_dict : Dictionary = {
		"char_sheet_name" : filename.erase(filename.length() - 5, filename.length() - 1).capitalize(),
		"sheet_template" : template.to_snake_case(),
		"pc_name" : character_sheet.get_node("character_sheet/sheet_container/section01/background/background_items/name/input").text,
		"player_name" : character_sheet.get_node("character_sheet/sheet_container/section01/background/background_items/player/input").text,
		"bloodline" : character_sheet.get_node("character_sheet/sheet_container/section01/background/background_items/bloodline/input").text,
		"origin" : character_sheet.get_node("character_sheet/sheet_container/section01/background/background_items/origin/input").text,
		"post" : character_sheet.get_node("character_sheet/sheet_container/section01/background/background_items/post/input").text,
		"major_milestones" : character_sheet.get_node("character_sheet/sheet_container/section01/milestones/container/major_milestones/input").text,
		"minor_milestones" : character_sheet.get_node("character_sheet/sheet_container/section01/milestones/container/minor_milestones/input").text,
		"drives" : character_sheet.get_node("character_sheet/sheet_container/section01/drives/input").text,
		"mires" : mires,
		"edges" : edges,
		"skills" : skills,
		"languages" : languages,
		"resource_01" : character_sheet.get_node("character_sheet/sheet_container/section02/resources/resources_container/resource01/input").text,
		"resource_02" : character_sheet.get_node("character_sheet/sheet_container/section02/resources/resources_container/resource02/input").text,
		"resource_03" : character_sheet.get_node("character_sheet/sheet_container/section02/resources/resources_container/resource03/input").text,
		"resource_04" : character_sheet.get_node("character_sheet/sheet_container/section02/resources/resources_container/resource04/input").text,
		"aspects" : aspects,
		"temporary_tracks" : temporary_tracks
	}
	return save_dict

