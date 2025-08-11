extends Item
	
func init():
	name = "寒箭"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atkRan = 2
	att.spd = 0.4
	
	info = tr("普通攻击20%概率获得5层[急速]") + "\n" + tr("当你拥有[急速]，普通攻击也附加4层[结霜]")

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		if sys.rndPer(20):
			masCha.addBuff(b_jiSu.new(5))
		
		var bf: Buff = masCha.hasBuff("b_jiSu")
		if bf != null:
			atkInfo.hitCha.addBuff(b_jieShuang.new(4))
