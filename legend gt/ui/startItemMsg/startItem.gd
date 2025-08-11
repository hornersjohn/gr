extends Control

signal selCha(item)



var it = null
var is_sel = false
var can_act: bool = true
onready var name_lable = $name_lable
const c = Color("a7e0ff")


func _ready():
	pass


func init(id):
	var item = sys.newItem(id)
	it = item
	var itemBt = preload("res://ui/item/item.tscn").instance()
	itemBt.init(item)
	itemBt.get_node("Sprite").visible = false
	add_child(itemBt)
	itemBt.isDrag = false
	name_lable.text = item.name
	itemBt.margin_top = 15
	itemBt.margin_left = 34
	


func _on_Button_pressed():
	if not can_act: return
	is_sel = not is_sel
	if is_sel == true:
		
		$".".self_modulate = c * 2.5
		$Button.text = "取消"
	else:
		$".".self_modulate = Color.white
		$Button.text = "选择"

	
	emit_signal("selCha", self)

func set_false():
	can_act = false
	$".".modulate = Color("#666666")
	if sys.sel_num <= 0:
		$Button.text = "上限"

func set_true():
	can_act = true
	$".".modulate = Color.white
	if is_sel == true:
		$Button.text = "取消"
	else:
		$Button.text = "选择"
