extends TextureButton
signal onEvoPressed(cha)
var masCha = null

func _ready():
	pass

func init(cha):
	masCha = cha
	cha.isItem = true
	cha.position = Vector2(texture_normal.get_width() / 2, texture_normal.get_height() - 35)
	add_child(cha)

func _on_Button_pressed():
	emit_signal("onEvoPressed", masCha)
