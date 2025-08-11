extends "res://ui/msgBase/msgBase.gd"




onready var txt = $RichTextLabel
var talent = null

func _ready():
	pass

func init(talent):
	popup()
	self.talent = talent
	upInfo()
	
func upInfo():
	if talent.lv < 5:
		var s = talent.info + "\n\n"
		s += "升级后\n\n"
		talent.lv += 1
		s += talent.info + "\n\n"
		talent.lv -= 1
		s += "升级花费：%d" % [talentData.lvP[talent.lv]]
		txt.bbcode_text = s
		upP()
	else:
		txt.bbcode_text = "满级了！无法再升级"
		$Button.hide()

func _on_Button_pressed():
	if talentData.subP(talentData.lvP[talent.lv]):
		talent.lv += 1
		talentData.infoDs[talent.id].lv += 1
		talentData.saveInfo()
		sys.newBaseMsg("信息", "升级成功")
		upInfo()
	else:
		sys.newBaseMsg("信息", "魂值不足")

func _on_Button2_pressed():
	queue_free()

func upP():
	$Label.text = "魂：%d" % talentData.p
