extends WindowDialog





var itemDs = {}
onready var box = $ScrollContainer / VBoxContainer

func _ready():
	sys.main.connect("onCharaHurt", self, "hurt")
	
func up():
	pass
	
func clear():
	itemDs.clear()
	for i in box.get_children():
		i.queue_free()
		
func hurt(atkInfo: AtkInfo):
	var nowLab = null
	if atkInfo.atkCha.team == 1:
		if itemDs.has(atkInfo.atkCha) == false:
			var lab = preload("res://ui/dpsMsg/dpsItem.tscn").instance()
			box.add_child(lab)
			itemDs[atkInfo.atkCha] = lab
			nowLab = lab
			lab.masCha = atkInfo.atkCha
		else:
			nowLab = itemDs[atkInfo.atkCha]

		nowLab.plusSc(atkInfo.hurtVal)
		
		var n = - 1
		for i in range(nowLab.get_index() - 1, - 1, - 1):
			if nowLab.sc > box.get_child(i).sc:
				n = i
			else:
				break
		
		if n != - 1: box.move_child(nowLab, n)

	pass

func _on_Control_popup_hide():
	hide()

