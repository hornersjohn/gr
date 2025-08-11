extends WindowDialog

onready var vbox = $ScrollContainer / VBoxContainer

var lvStep = 1
var maxLLv = 3

func _ready():
	connect("about_to_show", self, "up")
	if sys.isDemo:
		maxLLv = 2
	
func init():
	var btLv = 1.0
	var lvXius = [1.0, 1.5, 2.0, 2.5, 3.0, 3.5]
	for l in range(maxLLv):
		for i in guanKaData.data:
			var lvXiu = lvXius[l]
			var box = preload("res://ui/guanKaMsg/box.tscn").instance()
			vbox.add_child(box)
			if i == "boss":
				var item = preload("res://ui/guanKaMsg/item.tscn").instance()
				box.add_child(item)
				item.initBat(btLv * lvXiu, 2)
				item.connect("onPressed", self, "_onPressed")
			elif i == "xiu":
				var item = preload("res://ui/guanKaMsg/item.tscn").instance()
				box.add_child(item)
				item.initXiuXi()
				item.connect("onPressed", self, "_onPressed")
			elif i == "shop":
				var item = preload("res://ui/guanKaMsg/item.tscn").instance()
				box.add_child(item)
				item.initShop(i)
				item.connect("onPressed", self, "_onPressed")
			elif i == "baoWu":
				var item = preload("res://ui/guanKaMsg/item.tscn").instance()
				box.add_child(item)
				item.initBaoWu(2)
				item.connect("onPressed", self, "_onPressed")
			else:
				for j in range(sys.rndRan(1, 3)):
					var item = preload("res://ui/guanKaMsg/item.tscn").instance()
					box.add_child(item)
					if j == 1:
						if sys.rndPer(20): item.initBat(btLv * lvXiu, 1)
						else: item.initBat(btLv * lvXiu)
					elif j == 2 and sys.rndPer(30):
						if sys.rndPer(50) and btLv > 5:
							item.initDuBo()
						else: item.initBaoWu(1)
					else: item.initBat(btLv * lvXiu)
					item.connect("onPressed", self, "_onPressed")
				btLv += 1
			box.modulate = Color("555555")
	nextLv()
	
func up():
	var bat = $ScrollContainer.get_v_scrollbar()
	bat.ratio = float(lvStep - 3) / (guanKaData.data.size() * maxLLv)
		
func _onPressed(item):
	endLv(lvStep - 1)
	nextLv()
	hide()
	if item.type == 1:
		if item.batType == 2:
			var msg = sys.newBaseMsg("BOSS战", "BOSS战胜利你的单位将满血复活。")
			yield(msg, "popup_hide")
		sys.main.batLv = lvStep
		sys.main.battleReady(item.lvcs, item.lvzb, item.batType)
	elif item.type == 2:
		var msg = sys.newMsg("shopMsg")
		msg.init(sys.main.player)
	elif item.type == 3:
		var msg = sys.newBaseMsg("行军休息", "你的所有单位回满生命值")
		yield(msg, "popup_hide")
		sys.main.chasPlusHp(2, 2)
		sys.main.showMao()
	elif item.type == 4:
		var msg = sys.newMsg("baoWuMsg")
		if item.batType == 1:
			msg.init(sys.main.player)
		elif item.batType == 2:
			msg.initBig(sys.main.player)
	elif item.type == 5:
		sys.newMsg("duBoMsg").init(sys.main.player)
			
func _on_Control_popup_hide():
	hide()

func nextLv():
	up()
	var box = vbox.get_child(lvStep - 1)
	if box != null:
		box.modulate = Color("ffffff")
		for i in box.get_children():
			i.disabled = false
		lvStep += 1

func endLv(lv):
	var box = vbox.get_child(lv - 1)
	box.modulate = Color("555555")
	for i in box.get_children():
		i.disabled = true

func _on_guanKaMsg_about_to_show():
	audio.playSe("msg")
	pass
	
func infoGet():
	if sys.main.guanKaBtn.step != 1: lvStep -= 1
	var dic = {}
	var i = 0
	for iitem in $ScrollContainer / VBoxContainer.get_children():
		dic[i] = {}
		var j = 0
		for jitem in iitem.get_children():
			dic[i][j] = {type = jitem.type, lv = jitem.lv, lvcs = jitem.lvcs, batType = jitem.batType, lvzb = jitem.lvzb}
			j += 1
		i += 1
	
	var adic = {
		lvStep = lvStep, 
		items = dic, 
		maxLLv = maxLLv
	}
	return adic
	
func infoSet(dic):
	lvStep = dic["lvStep"]
	maxLLv = dic["maxLLv"]
	var ni = 2
	for i in dic["items"].values():
		var box = preload("res://ui/guanKaMsg/box.tscn").instance()
		vbox.add_child(box)
		if lvStep == ni:
			box.modulate = Color("ffffff")
		else: box.modulate = Color("555555")
		for j in i.values():
			var item = preload("res://ui/guanKaMsg/item.tscn").instance()
			box.add_child(item)
			item.disabled = true
			item.connect("onPressed", self, "_onPressed")
			if j["type"] == 1:
				var batType = j["batType"]
				item.loadBat(j["lv"], batType, j["lvcs"], j["lvzb"])
			elif j["type"] == 2:
				item.initShop(j["lv"])
			elif j["type"] == 3:
				item.initXiuXi()
			elif j["type"] == 4:
				item.initBaoWu(j["batType"])
			elif j["type"] == 5:
				item.initDuBo()
			
			if lvStep == ni:
				item.disabled = false
		ni += 1
	up()


func _on_guanKaMsg_tree_exited():
	
	pass
