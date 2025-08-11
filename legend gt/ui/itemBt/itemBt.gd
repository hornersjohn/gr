extends TextureRect

export  var id = ""
var masCha = null

func _ready():
	if id != "":
		var cha = preload("res://core/chara.tscn").instance()



		cha.set_script(load("{dir}/{id}/{id}.gd".format({id = id, dir = chaData.infoDs[id].dir})))
		cha.id = id
		cha.team = 1
		cha.isDrag = false
		cha.get_node("ui/hpBar").hide()
		init(cha)
		cha.set_process(false)
		
func init(chal: Chara):
	chal.isItem = true
	chal.position = Vector2(texture.get_width() / 2, texture.get_height() - 35)
	masCha = chal
	add_child(chal)

func msgInfo(cha):
	var msg = preload("res://ui/charaInfoMsg/charaInfoMsg.tscn").instance()
	get_node("../../../../../topUi").add_child(msg)
	msg.init(cha, cha.getInfo())
