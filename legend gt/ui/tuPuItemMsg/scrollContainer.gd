extends ScrollContainer








func _ready():
	pass




var m1pos = Vector2()
var m1Stage = false
var pos = Vector2()
func _input(event: InputEvent):
	var pos = Vector2(scroll_horizontal, scroll_vertical)
	if m1Stage:
		pos += (m1pos - get_parent().get_global_mouse_position())
		scroll_horizontal = pos.x
		scroll_vertical = pos.y
		print(scroll_vertical)
	if event.is_action_pressed("ui_m1"):
		m1Stage = true
		m1pos = get_parent().get_global_mouse_position()
	if event.is_action_released("ui_m1"):
		m1Stage = false
	
