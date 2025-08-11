extends "res://ui/msgBase/msgBase.gd"

var infoCha: Chara = null
var bfDir = config.bfDir

func _on_Button_pressed():
	if infoCha != null:
		queue_free()
		var msg = sys.newMsg("evolutionMsg")
		msg.popup()
		msg.init(infoCha)

func init(cha, s = ""):
	popup()
	infoCha = cha
	
	for i in bfDir.keys():
		s = s.replace("%s" % tr(i), "[color=#ffff55][url={id}]{ids}[/url][/color]".format({id = i, ids = tr(i)}))
	$txt.bbcode_text = s
	$Button.disabled = not infoCha.sureEvo
	if is_instance_valid(sys.main) and sys.main.isAiStart: $Button.disabled = true

func _on_txt_meta_clicked(meta):
	sys.newBaseMsg(meta, tr(bfDir[meta]))
	
