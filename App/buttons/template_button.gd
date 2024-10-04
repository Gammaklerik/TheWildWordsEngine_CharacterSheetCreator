extends Button

var template_name : String
signal template_selected

func _ready():
	text = template_name
	connect("template_selected", func(): get_parent().get_parent()._on_template_selected(template_name))

func _on_pressed():
	template_selected.emit()
