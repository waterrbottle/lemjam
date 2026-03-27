extends Label

func _ready():
	visible_ratio = 0.0
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, "visible_ratio", 1.0, text.length() * 0.04)
