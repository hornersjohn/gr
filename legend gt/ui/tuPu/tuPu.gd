extends "res://ui/msgBase/msgBase.gd"

onready var box = $ScrollContainer / HBoxContainer

func _ready():
	pass
	
func _on_Button_pressed():
	queue_free()
	pass

func init():
	popup()
	for i in chaData.infos:
		if i.lv > 3 or i.hide:
			continue
		var bid = chaData.getLvIds(i.id, 1)
		var node = findNode(box, bid)
		var lvNode = null
		
		if node == null:
			node = VBoxContainer.new()
			node.name = bid
			box.add_child(node)
		lvNode = findNode(node, str(i.lv))
		if lvNode == null:
			lvNode = HBoxContainer.new()
			lvNode.alignment = BoxContainer.ALIGN_CENTER
			lvNode.name = str(i.lv)
			node.add_child(lvNode)
		var chaBt = preload("res://ui/itemBt/itemBt.tscn").instance()
		chaBt.id = i.id
		lvNode.add_child(chaBt)

func findNode(node, id):
	for i in node.get_children():
		if i.name == id:
			return i
	return null
