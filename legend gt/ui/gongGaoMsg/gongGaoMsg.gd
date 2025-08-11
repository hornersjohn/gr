extends WindowDialog








func _ready():
	popup()







func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open("https://store.steampowered.com/app/1595280/CardMaker/")


func _on_Button_pressed():
	queue_free()
	pass


func _on_WindowDialog_popup_hide():
	queue_free()
	pass
