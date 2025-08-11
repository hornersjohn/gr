extends "res://ui/msgBase/msgBase.gd"




var lv = 0
var infos = jinJieData.infos

func _ready():
	upInfo(jinJieData.ulokLv)
	if jinJieData.ulokLv >= 5:
		$NinePatchRect2.show()
	else:
		$NinePatchRect2.show()

func init():
	popup()

func _on_r_pressed():
	if lv >= jinJieData.maxLv:
		sys.newBaseMsg("提示", "这是暂时最高的等级。")
		return
	if lv >= jinJieData.ulokLv:
		sys.newBaseMsg("提示", "你需要通关当前等级，才能解锁下一个等级。")
		return
	lv += 1
	if lv > jinJieData.maxLv: lv = jinJieData.maxLv
	upInfo()

func _on_l_pressed():
	lv -= 1
	if lv < 0: lv = 0
	upInfo()
	
func upInfo(lv = null):
	if lv != null: self.lv = lv
	lv = self.lv
	$NinePatchRect / Control / lv.text = str(lv)
	$NinePatchRect / Control / info.text = infos[lv]
	
func _on_Button_pressed():
	if sys.isDemo and lv != 0:
		sys.newBaseMsg("提示", "试玩版只能玩难度0。")
		return
	jinJieData.nowLv = lv
	queue_free()
	sys.get_node("../Control").queue_free()
	var main = preload("res://main.tscn").instance()
	sys.get_parent().add_child(main)
	main.init()
	pass


func _on_wjBtn_pressed():
	jinJieData.nowLv = 5
	queue_free()
	sys.get_node("../Control").queue_free()
	var main = preload("res://main.tscn").instance()
	sys.get_parent().add_child(main)
	main.init(1)
	
