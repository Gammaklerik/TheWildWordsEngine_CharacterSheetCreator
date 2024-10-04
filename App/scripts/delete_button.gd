extends Button

signal deleted

func _ready():
	connect("deleted", get_parent().get_parent().get_parent().get_child(2).template_deleted)

func _on_pressed():
	deleted.emit()
	get_parent().get_parent().remove_child(get_parent())
	get_parent().queue_free()
