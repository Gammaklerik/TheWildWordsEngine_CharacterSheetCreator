extends Button

var track_idx : int
@export var mark : CompressedTexture2D
@export var burn : CompressedTexture2D

func _ready():
	change_mark()

func _on_pressed():
	if track_idx != 2:
		track_idx += 1
		# If a track marker further down is marked while the previous are blank,
		# the previous track markers are iterated through and marked.
		if self.name != "track_marker01":
			for child in self.get_parent().get_children():
				if child == self:
					break
				if child.is_in_group("marker"):
					if child.icon != mark && child.icon != burn:
						child.icon = mark
						child.track_idx = 1
	else:
		track_idx = 0
		var can_modify : bool = false
		if self.get_parent().is_in_group("track"):
			# If a track marker is made blank, all subsequent markers are made blank
			# as well.
			for child in self.get_parent().get_children():
				if child != self && can_modify:
					if child.is_in_group("marker"):
						child.icon = null
						child.track_idx = 0
				if child == self:
					can_modify = true
	change_mark()

func change_mark():
	if track_idx == 0:
		icon = null
	elif track_idx == 1:
		icon = mark
	elif track_idx == 2:
		icon = burn
