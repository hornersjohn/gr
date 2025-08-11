extends TextureButton

var type = 1
var price = 70
var info = null
signal onPressed(btn)
var isShow = false
onready var f = $f

func _ready():
	$Label.text = "%dG" % price

func init(id, type = 1):
	self.type = type
	if type == 1:
		var ib = preload("res://ui/item/item.tscn").instance()
		f.add_child(ib)
		ib.margin_left = 50
		ib.margin_top = 50
		var item = sys.newItem(id)
		ib.init(item)
		ib.dianHide()
		ib.isDrag = false
		info = item
	else:
		var ib = preload("res://ui/itemBt/itemBt.tscn").instance()
		f.add_child(ib)
		var cha = sys.main.newChara(id)
		cha.isDrag = true
		cha.team = 2
		ib.init(cha)
		info = cha

func _on_Button_pressed():
	if sys.main.player.subGold(price):
		isShow = true
		$AnimationPlayer.play("show")
		$Button.hide()
		$Label.hide()
	else:
		sys.newBaseMsg("信息", "金币不足")
	
