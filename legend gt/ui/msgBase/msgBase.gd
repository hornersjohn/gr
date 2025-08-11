extends WindowDialog
class_name MsgBase
var tw = Tween.new()
func _ready():
	add_child(tw)
	connect("about_to_show", self, "_on_Control_about_to_show")
	connect("popup_hide", self, "_on_Control_popup_hide")
	audio.playSe("msg")

func _on_Control_about_to_show():
	tw.interpolate_property(self, "rect_scale", Vector2(1, 0), Vector2(1, 1), 0.15, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.interpolate_property(self, "modulate", Color("00ffffff"), Color("ffffff"), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()

func _on_Control_popup_hide():




	queue_free()
	audio.playSe("x")

func _on_Button2_pressed():
	queue_free()
	pass

func _input(event):
	if event.is_action_pressed("ui_m2"):
		queue_free()
