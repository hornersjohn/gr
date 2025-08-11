extends WindowDialog






func _ready():
	pass

func init():
	popup()


func _on_Button_pressed():
	sys.main.player.addCha(sys.main.newChara($addCha / LineEdit.text))

func _on_Button_pressed2():
	sys.main.player.addItem(sys.newItem($addItem / LineEdit.text))

func _on_Button_pressed3():
	sys.main.player.plusGold($addGold / LineEdit.value)

func _on_Button_pressed4():
	sys.main.player.plusEmp($addIEmp / LineEdit.value)
