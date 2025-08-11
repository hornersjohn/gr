extends "res://ui/msgBase/msgBase.gd"





onready var hq = $HTTPRequest
var dc = null

func _ready():
	pass

var item = null



func init(dc, item):
	self.dc = dc
	popup()
	$Label.text = dc["title"]
	$RichTextLabel.bbcode_text = dc["description"]
	self.item = item
	$TextureRect.texture = item.get_node("Sprite").texture
	
	item.connect("onLimg", self, "l")
	if Steam.getItemState(dc["fileID"]) > 0:
		$Button.pressed = true
	else: $Button.pressed = false
	
func l():
	$TextureRect.texture = item.get_node("Sprite").texture

func _on_Button_pressed():
	if $Button.pressed == true:
		Steam.subscribeItem(dc["fileID"])
		sys.newBaseMsg("提示", "已订阅，需要重启游戏生效。")
	else:
		Steam.unsubscribeItem(dc["fileID"])
		sys.newBaseMsg("提示", "已取消订阅，需要重启游戏生效。")

