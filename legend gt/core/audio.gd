extends Node2D

onready var bgmPlay = $AudioStreamPlayer
onready var sePlay = $AudioStreamPlayer2

var bgmVol = 0.7 setget set_bgmVol
var seVol = 0.7 setget set_seVol
var lg = "zh_CN" setget set_lg

var lgDs = {
	schinese = "zh_CN", 
	tchinese = "zh_CN", 
	english = "en", 
	japanese = "ja"
}

func _ready():
	TranslationServer.set_locale("zh_CN")

func playBgm(name):
	bgmPlay.stream = load("res://res/bgm/%s.ogg" % name)
	bgmPlay.play()
	
func playSe(name):
	if sePlay != null:
		sePlay.stream = load("res://res/se/%s.wav" % name)
		sePlay.play()
	
func set_bgmVol(val):
	bgmVol = val
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), 10 * log(val) + 6)
	
func set_seVol(val):
	seVol = val
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SE"), 10 * log(val) + 6)
	
func set_lg(val):
	if val == "":
		if sys.godotSteam != null:
			var key = sys.godotSteam.getSteamUILanguage()
			if lgDs.has(key):
				val = lgDs[key]
			else:
				val = "en"
		else:
			val = "zh_CN"
	lg = val
	TranslationServer.set_locale(val)

func loadInfo():
	var file = File.new()
	if file.open("user://data1/audio.save", File.READ) == OK:
		var dic = parse_json(file.get_line())
		file.close()
		if dic == null: print_debug("读取存档错误")
		if dic.has("bgmVol"): audio.bgmVol = dic["bgmVol"]
		if dic.has("seVol"): audio.seVol = dic["seVol"]
		if dic.has("lg"): audio.lg = dic["lg"]
		return dic
	
func saveInfo():
	var file = File.new()
	var dir = Directory.new()
	dir.make_dir_recursive("user://data1/")
	var dic = {
		bgmVol = bgmVol, 
		seVol = seVol, 
		lg = lg
	}
	file.open("user://data1/audio.save", File.WRITE)
	file.store_line(to_json(dic))
	file.close()
