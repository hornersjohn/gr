extends "res://ui/msgBaseX/msgBaseX.gd"

onready var grld = $Panel / CenterContainer / HBoxContainer

func _ready():
	pass
	
var batType = 0

func init(batType = 0):
	self.batType = batType
	upChas()
		
	popup()
	if batType == 0: $Panel / Label.text = "战斗胜利！获得战利品。"
	elif batType == 1: $Panel / Label.text = "精英战斗胜利！获得战利品。"
	elif batType == 2: $Panel / Label.text = "BOSS战胜利！获得战利品。"
	var g = 30; var emp = 100
	if batType == 0:
		g = 20
		emp = 30
	elif batType == 1:
		g = 40
		emp = 60
	elif batType == 2:
		g = 80
		emp = 120
	sys.main.player.plusGold(g)
	sys.main.player.plusEmp(emp)
	if batType == 2:
		$Panel / RichTextLabel.bbcode_text = tr("你的单位满血复活").format({gold = g})
	else:
		$Panel / RichTextLabel.bbcode_text = tr("场上单位恢复30%HP").format({gold = g})
	$Panel / RichTextLabel.bbcode_text += tr("\n经验值+%d") % emp
	$Panel / Button2.hide()
	if sys.adSdk != null and batType == 2:
		$Panel / Button2.show()
	if sys.adSdk != null:
		sys.adSdk.connect("onError", self, "onError")
		sys.adSdk.connect("onRewardVerify", self, "onRewardVerify")
		
func _onPressed(cha):
	if not sys.main.isAiStart:
		var chal = sys.main.newChara(cha.id)
		sys.main.player.addCha(chal)
		hide()

func upChas():
	var pl: RndPool = sys.main.chaPool
	var jlPool = null
	var nums = [1, 1.5, 2, 2, 2, 2, 2, 2, 2]
	var jlNum = nums[sys.main.batLLv]
	if batType == 0:
		jlPool = RndPool.new([[1, 100], [2, 3], [3, 1]])
	elif batType == 1:
		jlPool = RndPool.new([[1, 0], [2, 50], [3, 0]])
		jlNum = jlNum * 2
	elif batType == 2:
		jlPool = RndPool.new([[1, 0], [2, 0], [3, 5]])
		if sys.adSdk == null:
			jlNum = jlNum * 4
		else:
			jlNum = jlNum * 2
	var pn = 0
	var lvpow = int(jlNum)
	var lvcs = []
	while pn != lvpow:
		sys.main.rndLv = lvpow - pn
		var info = pl.rndItem()
		var s = info
		if s == "": print_debug("随到单位id出错")
		var n = 9 / pl.getItemW(info)
		if pn + n <= lvpow:
			pn += n
			lvcs.append(s)
			if lvcs.size() >= 20: break
	
	for i in lvcs:
		var id = i
		
		var cha = sys.main.newChara(id)
		var bt = preload("res://ui/itemBt/itemBt.tscn").instance()
		grld.add_child(bt)
		bt.init(cha)

func _on_Control_popup_hide():
	queue_free()

func _on_Button_pressed():
	if not sys.main.isAiStart:
		for i in grld.get_children():
			var chal = sys.main.newChara(i.masCha.id)
			sys.main.player.addCha(chal)
	hide()

func _on_Button2_pressed():
	if sys.adPlay():
		$Panel / Button2.hide()
		
func onRewardVerify():
	yield(get_tree().create_timer(0.1), "timeout")
	upChas()
	
func onError():
	$Panel / Button2.show()
