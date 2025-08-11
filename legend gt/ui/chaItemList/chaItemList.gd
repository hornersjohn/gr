extends Control
var masCha: Chara = null

onready var list = $g

func _ready():
	masCha = get_node("../../")
	masCha.connect("onAddItem", self, "addItem")
	masCha.connect("onDelItem", self, "delItem")

func addItem(item):
	var k = preload("res://ui/item/item.tscn").instance()
	k.init(item)
	k.dianHide()
	list.add_child(k)
	
func delItem(item):
	for i in list.get_children():
		if i.item == item:
			i.queue_free()
			return
