extends Item
	
func init():
	name = "白银盾"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 10
	att.mgiDef = 70
	att.maxHp = 300
	info = "免疫所有负面状态！"
	
func _connect():
	masCha.connect("onAddBuff", self, "onAddBuff")

func onAddBuff(buff: Buff):
	if buff.isNegetive:
		buff.isDel = true
