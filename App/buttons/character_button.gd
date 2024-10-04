extends Button

var file_name : String
var template_name
signal character_selected

func _ready():
	text = file_name
	get_child(0).text = template_name + " Template"
	connect("character_selected", func(): get_parent().get_parent()._on_character_selected(file_name, template_name))

func _on_pressed():
	character_selected.emit()
