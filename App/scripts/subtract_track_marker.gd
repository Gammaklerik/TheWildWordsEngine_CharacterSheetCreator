extends Button

@export var track : BoxContainer
signal marker_subtracted

func _on_pressed():
	track.get_child(track.get_child_count() - 1).free()
	if track.get_child_count() == 1:
		disabled = true
	marker_subtracted.emit()

func _on_add_track_marker_marker_added():
	if track.get_child_count() > 1:
		disabled = false
