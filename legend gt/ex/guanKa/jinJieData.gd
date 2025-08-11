extends Node

var ulokLv = 0
var maxLv = 6
var nowLv = 0

var infos = [
	"初探游戏规则", 
	"对规则有一定的了解", 
	"你现在是一个小熟手。", 
	"越来越熟练了，达尔文见到你都会害羞。", 
	"你已经逐渐掌握游戏。", 
	"完成这个难度，作为一般人已经算通关游戏！", 
	"这个难度是为骨灰玩家而准备的，需要完美的理解和足够的运气！", 
	"你就是现代达尔文！", 
]

func upLv():
	if jinJieData.nowLv == jinJieData.ulokLv and jinJieData.nowLv < maxLv:
		jinJieData.ulokLv += 1
		saveInfo()
		return true
	return false

func loadInfo():
	var file = File.new()
	if file.open("user://data1/jinJieData.save", File.READ) == OK:
		var dic = parse_json(file.get_line())
		file.close()
		if dic == null: print_debug("读取存档错误")
		if dic.has("ulokLv"): ulokLv = dic["ulokLv"]
		return dic
	
func saveInfo():
	var file = File.new()
	var dir = Directory.new()
	dir.make_dir_recursive("user://data1/")
	var dic = {
		ulokLv = ulokLv
	}
	file.open("user://data1/jinJieData.save", File.WRITE)
	file.store_line(to_json(dic))
	file.close()
