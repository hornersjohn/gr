extends "res://ui/msgBaseX/msgBaseX.gd"

onready var grid = $Panel / ScrollContainer / GridContainer
var player: Player = null

		
func init(player: Player):
	self.player = player
	var pl = RndPool.new([[1, 100], [2, 10]])
	for i in range(pl.rndItem()):
		if sys.rndPer(40):
			var id = itemData.rndPool.rndItem().id
			addItem(id, 1)
		else:
			var info = chaData.rndPool.rndItem(self, "rndCha")
			var id = info.id
			addItem(id, 2)
	popup()
	player.connect("onChangeGold", self, "_onChangeGold")
	_onChangeGold()
	$Panel / Label2.text = "小宝藏"
	
func initBig(player: Player):
	self.player = player
	var pl = RndPool.new([[2, 100], [3, 10]])
	for i in range(pl.rndItem()):
		if i == 0:
			var id = itemData.rndPool.rndItem().id
			addItem(id, 1)
		else:
			if sys.rndPer(40):
				var id = itemData.rndPool.rndItem().id
				addItem(id, 1)
			else:
				var info = chaData.rndPool.rndItem(self, "rndCha")
				var id = info.id
				addItem(id, 2)
	popup()
	player.connect("onChangeGold", self, "_onChangeGold")
	_onChangeGold()
	$Panel / Label2.text = "大宝藏"
		
func addItem(id, type = 1, p = null):
	var item = preload("res://ui/baoWuMsg/baoWuItem.tscn").instance()
	grid.add_child(item)
	item.init(id, type)
	
func _onChangeGold():
	$Panel / Label.text = "%dG" % player.gold

func rndCha(obj):
	if obj.lv <= 2: return true

func na(item):
	if item.type == 1:
		player.addItem(item.info)
		item.queue_free()
	else:
		item.get_node("Control").remove_child(item.info)
		player.addCha(item.info)
		item.queue_free()

func _on_Button_pressed():
	for i in grid.get_children():
		na(i)
	queue_free()
