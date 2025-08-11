extends ScrollContainer

class_name ScBox

func _ready():
	connect("scroll_ended", self, "scEnd")
	
	
func scEnd():
	if get_node("itemGrid").columns > get_node("itemGrid").get_child_count():
		if get_child_count() > 0:
			var node = get_child(0)
			if node.rect_position.x < 0:
				
				node.rect_position.x = 0
			if node.rect_position.y < 0:
				
				node.rect_position.y = 0
