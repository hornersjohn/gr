extends WindowDialog





func _ready():
	
	
	popup()
	pass

func init(info):
	$RichTextLabel.bbcode_text = info

func _on_WindowDialog_popup_hide():
	queue_free()
