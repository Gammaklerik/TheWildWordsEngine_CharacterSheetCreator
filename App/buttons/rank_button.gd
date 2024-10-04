extends Button

func _on_toggled(toggled_on):
	if toggled_on && self.name != "rank01":
		for child in self.get_parent().get_children():
			if child == self:
				break
			if !child.button_pressed:
				child.button_pressed = true
	elif !toggled_on && self.get_parent().name == "rank_track":
		var can_modify : bool = false
		for child in self.get_parent().get_children():
			if child != self && can_modify:
				child.button_pressed = false
			if child == self:
				can_modify = true
