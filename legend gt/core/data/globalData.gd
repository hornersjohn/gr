extends Node

var infoDs = {}
var infos = []

func _ready():
	pass
















func loadInfo(dname, dir):
	var g = load("%s/%s/%s.gd" % [dir, dname, dname]).new()
	infos.append(g)
	infoDs[dname] = g
	
