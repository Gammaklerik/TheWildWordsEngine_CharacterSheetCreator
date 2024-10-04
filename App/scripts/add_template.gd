extends Button

@export var template_container : Container
@export var template : PackedScene

func _on_pressed():
	var new_template = template.instantiate()
	template_container.add_child(new_template)
	if template_container.is_in_group("layout_editable"):
		new_template.get_child(0).editable = true
		new_template.get_child(2).visible = true
	if (template_container.name == "aspects_container" && template_container.get_child_count() == 7) || (template_container.name == "temporary_tracks_container" && template_container.get_child_count() == 3) || (template_container.name == "edges_container" && template_container.get_child_count() == 9) || (template_container.name == "skills_container" && template_container.get_child_count() == 18) || (template_container.name == "languages_container" && template_container.get_child_count() == 14) || (template_container.name == "mires_container" && template_container.get_child_count() == 4):
		disabled = true

func template_deleted():
	disabled = false
