extends "res://ui/msgBase/msgBase.gd"

func _ready():
	pass


func _on_Button_pressed():
	sys.newMsg("tuPu").init()


func _on_Button2_pressed():
	sys.newMsg("tuPuItemMsg").init()
	pass


func _on_Button3_pressed():
	sys.newMsg("tuPuBuff").init()


func _on_Button4_pressed():
	sys.newMsg("talentSelMsg").initTupu()
