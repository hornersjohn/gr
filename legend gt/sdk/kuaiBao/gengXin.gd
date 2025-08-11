extends Popup





var url = ""


func _ready():
	popup()

func init(txt, url, mode = "1"):
	self.url = url
	$Panel / RichTextLabel.text = txt
	if mode == "1":
		$Panel / Button2.hide()
	



func _on_Button2_pressed():
	queue_free()
	pass
	
func _on_Button_pressed():
	OS.shell_open(url)
	
	
