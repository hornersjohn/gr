extends NinePatchRect




signal onXuexi(talent)

var talentBt = null
var stage = 0


func _ready():
	pass




func init(id):
	var bt = preload("res://ui/talentBtn/talentBtn.tscn").instance()
	add_child(bt)
	var talent = sys.newTalent(id)
	talent.lv = talentData.infoDs[id].lv
	bt.init(talent)
	talentBt = bt
	bt.margin_left = 15
	bt.margin_top = 15
	$Label.text = "lv:%d" % [talent.lv + 1]
	stage = 0
	
func initTupu(id):
	var bt = preload("res://ui/talentBtn/talentBtn.tscn").instance()
	add_child(bt)
	var talent = sys.newTalent(id)
	talent.lv = talentData.infoDs[id].lv
	bt.init(talent)
	talentBt = bt
	bt.margin_left = 15
	bt.margin_top = 15
	$Label.text = "lv:%d" % [talent.lv + 1]
	talent.connect("changeLv", self, "changeLv")
	stage = 1
	if talent.lv <= 5:
		$Button.text = "升级"
		$Button.show()
	else:
		$Button.hide()

func changeLv():
	if talentBt.talent.lv < 5:
		$Label.text = "lv:%d" % [talentBt.talent.lv + 1]
	else:
		$Label.text = "lv:Max"

func _on_Button_pressed():
	emit_signal("onXuexi", talentBt.talent)
