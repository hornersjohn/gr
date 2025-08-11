extends "res://ui/msgBase/msgBase.gd"

var item: Item = null
var bfDir = config.bfDir

func init(item):
	popup()
	self.item = item
	var attStr = ""
	for i in range(config.attKeys.size()):
		if item.att.info[config.attKeys[i]] == 0.0:
			continue
		if i < 8:
			attStr += "%s + %d\n" % [tr(config.attStrs[i]), item.att.info[config.attKeys[i]]]
		else:
			attStr += "%s + %d%%\n" % [tr(config.attStrs[i]), item.att.info[config.attKeys[i]] * 100]
	var nameStr = "[color=%s]%s[/color]" % [config.itemGradeColors[1], tr(item.name)]
	var s = "%s\n[color=#71b569]%s[/color]\n[color=#4080c6]%s[/color]\n" % [nameStr, attStr, tr(item.info)]
	for i in bfDir.keys():
		s = s.replace("%s" % tr(i), "[color=#ffff55][url={id}]{ids}[/url][/color]".format({id = i, ids = tr(i)}))
	$txt.bbcode_text = s

func _on_txt_meta_clicked(meta):
	sys.newBaseMsg(meta, tr(bfDir[meta]))
