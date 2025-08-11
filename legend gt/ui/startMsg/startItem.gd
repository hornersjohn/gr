extends Control

signal selCha(item)



var cha = null
var is_sel: bool = false
var can_act: bool = true


func _ready():
	pass


func init(id):
	var bt = preload("res://ui/itemBt/itemBt.tscn").instance()
	var cha = sys.main.newChara(id, 2)
	bt.init(cha)
	cha.isItem = true
	self.cha = cha
	add_child(bt)
	
func _on_Button_pressed():
	if not can_act: return
	is_sel = not is_sel
	if is_sel == true:
		$".".self_modulate = Color.white * 3
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
