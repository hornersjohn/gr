extends "res://ui/msgBase/msgBase.gd"
var masCha: Chara = null

onready var grid = $ScrollContainer / GridContainer

func init(cha):
	masCha = cha
	var evos: Array = []
	for i in chaData.infoDs[masCha.id].evos:
		evos.append(i)
	if masCha.lv == 3:
		var info = chaData.Info.new()
		info.lv = 4
		info.id = "cex___%s" % chaData.getLvIds(cha.id, 1).right(1)
		evos.append(info)
	for i in range(evos.size()):
		var chal = sys.main.newChara(evos[i].id)
		chal.id = evos[i].id
		var bt = preload("res://ui/evolutionMsg/evoItem.tscn").instance()
		grid.add_child(bt)
		bt.init(chal)
		bt.connect("onEvoPressed", self, "_onPressed")

func _onPressed(cha):
	if not sys.main.isAiStart:
		sys.main.player.evoChara(masCha, cha.id)
		hide()
