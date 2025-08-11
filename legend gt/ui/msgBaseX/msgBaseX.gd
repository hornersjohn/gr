extends Popup
class_name MsgBaseX

var tw = Tween.new()
var panl = null
func _ready():
	add_child(tw)
	audio.playSe("msg")



func _on_msgBaseX_about_to_show():
	tw.interpolate_property(self, "rect_scale", Vector2(1, 0), Vector2(1, 1), 0.15, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.interpolate_property(self, "modulate", Color("00ffffff"), Color("ffffff"), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
	pass

func _on_msgBaseX_popup_hide():
	queue_free()
	audio.playSe("x")
