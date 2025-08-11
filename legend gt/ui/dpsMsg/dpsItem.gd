extends Label





var masCha = null
var sc = 0


func _ready():
	pass





func plusSc(val):
	sc += val
	text = "%s : %d" % [masCha.chaName, sc]
