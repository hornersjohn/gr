extends TextureRect
class_name ImgBtn
signal onPressed()

func _ready():
	if not sys.isMin:
		connect("mouse_entered", self, "enter")
		connect("mouse_exited", self, "exit")
	else:
		connect("gui_input", self, "runGui_input")

var mtime = 0
func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if event.pressed == true:
			mtime = 0
			set_process(true)
		if event.pressed == false and mtime < 0.5:
			emit_signal("onPressed")
			set_process(false)
			mtime = 5

func _process(delta):
	mtime += delta / Engine.time_scale
			
func runGui_input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		sys.addLastInPan(self)

func enter():
	pass
	
func exit():
	pass
