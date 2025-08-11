extends ImgBtn
class_name ItemBt

var item: Item = null
var masCha = null
var isDrag = true

var tw = Tween.new()
func _ready():
	add_child(tw)
	if OS.get_name() != "Windows":
		pass
	exit()
	focus_mode = 1
	connect("onPressed", self, "_on_item_pressed")
	
func init(item):
	self.item = item
	masCha = item.masCha
	if itemData.infoDs[item.id].dir.left(8) != "res://ex":
			var im = Image.new()
			
			im.load("%s/%s/ico.png" % [itemData.infoDs[item.id].dir, item.id])
			var imt = ImageTexture.new()
			imt.flags = 4
			imt.create_from_image(im)
			$TextureRect.texture = imt
			
	else:
		$TextureRect.texture = load("res://ex/item/%s/ico.png" % item.id)
	
	if item.type == config.EQUITYPE_EQUI:
		$Sprite.show()
	item.connect("onDel", self, "dianShow")
	item.connect("onSetCha", self, "dianHide")
	
func dianHide(): $Sprite.hide()
func dianShow(): $Sprite.show()

var w = 1.5
var s = 1
var msg = null
func enter():
	tw.interpolate_property(self, "rect_scale", Vector2(s, s), Vector2(w, w), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()



func exit():
	tw.interpolate_property(self, "rect_scale", Vector2(w, w), Vector2(s, s), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()




func _on_item_pressed():
	var msg = sys.newMsg("itemInfoMsg")
	msg.init(item)
	
func get_drag_data(position):
	if is_instance_valid(sys.main) == false: return
	if isDrag and item.type == config.EQUITYPE_EQUI and not sys.main.isAiStart and ( not is_instance_valid(item.masCha) or item.masCha.team == 1):
		var spr = TextureRect.new()
		var can = Control.new()
		spr.texture = $TextureRect.texture
		var rs = 1
		if sys.isMin: rs = 3
		spr.margin_top = - spr.texture.get_height() * 0.5 * rs
		spr.margin_left = - spr.texture.get_width() * 0.5 * rs
		spr.modulate = Color("aaffffff")
		spr.rect_scale *= rs
		can.add_child(spr)
		set_drag_preview(can)
		sys.main.selItem = self
		return false
	
func can_drop_data(pos, data):
	return true

func setCha(cha):
	if cha.team == 1 and cha.items.size() < 3:
		if item.masCha != null:
			item.masCha.delItem(item)
		if cha.addItem(item):
			masCha = cha
			
			
