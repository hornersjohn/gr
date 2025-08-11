extends TextureButton

var type = 1
var price = 100
var info = null
signal onPressed(btn)

func _ready():
	pass

func init(id, type = 1):
	self.type = type
	if type == 1:
		var ib = preload("res://ui/item/item.tscn").instance()
		add_child(ib)
		ib.margin_left = 50
		ib.margin_top = 50
		var item = sys.newItem(id)
		ib.init(item)
		ib.dianHide()
		ib.isDrag = false
		info = item
	else:
		var ib = preload("res://ui/itemBt/itemBt.tscn").instance()
		add_child(ib)
		var cha = sys.main.newChara(id)
		cha.isDrag = true
		cha.team = 2
		ib.init(cha)
		info = cha

func _on_Button_pressed():
	emit_signal("onPressed", self)
