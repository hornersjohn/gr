extends TextureButton

var type = 1
var price = 100
var info = null
signal onPressed(btn)

func _ready():
	pass

func init(id, type = 1, price = null):
	self.type = type
	if type == 1:
		var ib = preload("res://ui/item/item.tscn").instance()
		add_child(ib)
		ib.margin_left = 50
		ib.margin_top = 50
		var item: Item = sys.newItem(id)
		ib.init(item)
		ib.dianHide()
		ib.isDrag = false
		setPrice(item.price)
		info = item
	elif type == 2:
		var ib = preload("res://ui/itemBt/itemBt.tscn").instance()
		add_child(ib)
		var cha = sys.main.newChara(id)
		cha.isDrag = true
		cha.team = 2
		ib.init(cha)
		if price != null: setPrice(price)
		else: setPrice(100)
		info = cha
	else:
		var ib = Label.new()
		ib.text = "\n  恢复玩家\n  10点生命值"
		
		add_child(ib)
		if price != null: setPrice(price)
		else: setPrice(200)

func setPrice(val):
	price = val
	$Label.text = "%dG" % val

func _on_Button_pressed():
	emit_signal("onPressed", self)
