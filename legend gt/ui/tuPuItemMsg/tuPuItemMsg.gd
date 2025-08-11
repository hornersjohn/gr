extends "res://ui/msgBase/msgBase.gd"

onready var grid = $ScrollContainer / GridContainer

func _ready():
	for i in itemData.infos:
		if i.hide == false:
			var bt = preload("tupuItem.tscn").instance()
			var item = sys.newItem(i.id)
			grid.add_child(bt)
			bt.get_node("item").init(item)
			bt.get_node("Label").text = item.name
			bt.get_node("item/Sprite").hide()
		
func init():
	popup()


func _on_Button_pressed():
	queue_free()
	pass
