extends "res://ui/msgBase/msgBase.gd"




func init():
	popup()


func _ready():
	for i in $ScrollContainer / GridContainer.get_children():
		i.connect("pressed", self, "upInfo", [i])
	for i in $ScrollContainer / GridContainer2.get_children():
		i.connect("pressed", self, "upInfo", [i])
	pass
	
func _on_Button_pressed():
	queue_free()
	pass

func upInfo(btn):
	$RichTextLabel.bbcode_text = tr(config.bfDir[btn.text])

func _on_Buttons_pressed():
	$RichTextLabel.bbcode_text = tr("buff层数上限25，层数越高特效表现越强。")
	pass
