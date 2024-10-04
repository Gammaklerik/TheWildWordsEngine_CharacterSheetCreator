extends Button

@export var track : BoxContainer
@export var track_marker : PackedScene
signal marker_added

func _on_pressed():
	var new_marker = track_marker.instantiate()
	track.add_child(new_marker)
	if track.get_child_count() == 8:
		disabled = true
	marker_added.emit()

func _on_subtract_track_marker_marker_subtracted():
	if track.get_child_count() < 8:
		disabled = false
