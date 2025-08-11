extends "res://ui/msgBase/msgBase.gd"

func _ready():
	$HSlider.value = audio.bgmVol * 100
	$HSlider2.value = audio.seVol * 100
	$OptionButton.add_item("简体中文")
	$OptionButton.add_item("English")
	$OptionButton.add_item("日本語")
	
	$OptionButton.select(lgDs[audio.lg])
	if sys.isMin:
		$OptionButton.hide()

func init():
	popup()

func _on_HSlider_value_changed(value):
	audio.bgmVol = value / 100
	
func _on_HSlider2_value_changed(value):
	audio.seVol = value / 100

func _on_Control_tree_exiting():
	audio.saveInfo()


func _on_Button_pressed():
	sys.newMsg("zhiZuoMsg").init()
	pass

var lgDs = {
	"zh_CN": 0, 
	"en": 1, 
	"ja": 2
}

func _on_OptionButton_item_selected(id):
	if id == 0:
		audio.lg = "zh_CN"
	elif id == 1:
		audio.lg = "en"
	elif id == 2:
		audio.lg = "ja"
