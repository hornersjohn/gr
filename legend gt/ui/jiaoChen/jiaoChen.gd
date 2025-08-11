extends Control

func _ready():
	if jinJieData.nowLv > 0:
		queue_free()
		return
	
	yield(get_tree().create_timer(0.2), "timeout")
	$"1".show()
	yield(sys.main, "onPlaceChara")
	$"1".hide()
	$"2".show()
	yield(sys.main, "onPlaceItem")
	$"2".hide()
	$"4".show()
	yield(sys.main.player, "onAddTalent")
	$"4".hide()
	$"3".show()
	yield(sys.main, "onBattleReady")
	$"3/Label".text = "开始战斗"
	yield(sys.main, "onBattleStart")
	$"3".hide()
	yield(sys.main, "onSureEvo")
	sys.newBaseMsg("提示", "3个相同的生物会发光，点击他们可选择进化！！")
	queue_free()
	
