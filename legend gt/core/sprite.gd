extends ImgBtn
onready var masCha = get_node("../../../../")
var spr = null
onready var tw = $Tween

func _ready():
	pass

func get_drag_data(position):
	if masCha.isDrag and not sys.main.isAiStart and (sys.main.isTest or masCha.team == 1):
		spr = TextureRect.new()
		var can = Control.new()
		spr.texture = texture
		var rs = 1
		if sys.isMin: rs = 2
		spr.margin_top = - spr.texture.get_height() * rs * 0.5
		spr.margin_left = - spr.texture.get_width() * rs * 0.5
		spr.modulate = Color("aaffffff")
		spr.rect_scale *= rs
		can.add_child(spr)
		set_drag_preview(can)
		sys.main.selCha = masCha
		sys.main.showSelImg(spr.texture)
		sys.main.selSpr = spr
		return false
	
func can_drop_data(pos, data):
	return typeof(data) == TYPE_BOOL

var w = 1.5
func enter():
	tw.interpolate_property(self, "rect_scale", Vector2(1, 1), Vector2(w, w), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
	if masCha != null and masCha.isItem == false:
		masCha.get_node("ui/chaName").show()

func exit():
	tw.interpolate_property(self, "rect_scale", Vector2(w, w), Vector2(1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
	if masCha != null and masCha.isItem == false:
		masCha.get_node("ui/chaName").hide()
		
