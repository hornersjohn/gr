extends Node


var infoDs = {}

func _ready():
	pass
	
func loadInfo():
	var file = File.new()
	if file.open("user://data1/mod.save", File.READ) == OK:
		var dic: Dictionary = parse_json(file.get_line())
		infoDs = dic
		file.close()
		return dic
	
func saveInfo():
	var file = File.new()
	var dir = Directory.new()
	dir.make_dir_recursive("user://data1/")
	file.open("user://data1/mod.save", File.WRITE)
	file.store_line(to_json(infoDs))
	file.close()
