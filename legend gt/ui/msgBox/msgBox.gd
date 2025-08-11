extends WindowDialog



var tw = Tween.new()
func _ready():
	add_child(tw)
	audio.playSe("msg")
	connect("about_to_show", self, "_on_Control_about_to_show")

func _on_Control_about_to_show():
	tw.interpolate_property(self, "rect_scale", Vector2(1, 0), Vector2(1, 1), 0.15, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.interpolate_property(self, "modulate", Color("00ffffff"), Color("ffffff"), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()

func init(tileTxt = "信息", info = ""):
	popup()
	$RichTextLabel.bbcode_text = info
	window_title = tileTxt

func _on_Button_pressed():
	audio.playSe("x")
	queue_free()
	pass
func _on_WindowDialog_popup_hide():
	queue_free()
	audio.playSe("x")
	pass


func _on_WindowDialog_hide():
	queue_free()
