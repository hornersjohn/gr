extends "res://ui/msgBaseX/msgBaseX.gd"

onready var grid = $Panel / ScrollContainer / GridContainer
var player: Player = null

func _ready():
	popup()
		
func init(player: Player):
	up(player)




	player.connect("onChangeGold", self, "_onChangeGold")
	_onChangeGold()
	if sys.adSdk == null:
		$Panel / Button2.hide()
	else:
		sys.adSdk.connect("onError", self, "onError")
		sys.adSdk.connect("onRewardVerify", self, "onRewardVerify")
		
func up(player):
	self.player = player
	for i in range(3):
		var id = itemData.rndPool.rndItem().id
		addItem(id, 1, 200)
	for i in range(3):
		var info = chaData.rndPool.rndItem(self, "rndCha1")
		var id = info.id
		addItem(id, 2, 67)
	for i in range(3):
		var info = chaData.rndPool.rndItem(self, "rndCha2")
		var id = info.id
		addItem(id, 2, 200)
	for i in range(1):
		addItem("", 3, 200)
	
func addItem(id, type = 1, p = null):
	var item = preload("res://ui/shopMsg/shopItem.tscn").instance()
	grid.add_child(item)
	item.init(id, type, p)
	item.connect("onPressed", self, "mai")
	
func _onChangeGold():
	$Panel / Label.text = "%dG" % player.gold

func rndCha1(obj):
	if obj.lv == 1: return true
func rndCha2(obj):
	if obj.lv == 2: return true
func rndCha3(obj):
	if obj.lv == 3: return true
	
func onRewardVerify():
	for i in $Panel / ScrollContainer / GridContainer.get_children():
		i.free()
	yield(get_tree().create_timer(0.1), "timeout")
	up(player)
	
func onError():
	$Panel / Button2.show()

func mai(item):
	if player.subGold(item.price):
		if item.type == 1:
			player.addItem(item.info)
			item.queue_free()
		elif item.type == 2:
			item.get_node("Control").remove_child(item.info)
			player.addCha(item.info)
			item.queue_free()
		else:
			player.plusHp(10)
			item.queue_free()
	else:
		sys.newBaseMsg("信息", "金币不足")

func _on_Button_pressed():
	queue_free()

func _on_Button2_pressed():
	if sys.adPlay():
		$Panel / Button2.hide()
		


