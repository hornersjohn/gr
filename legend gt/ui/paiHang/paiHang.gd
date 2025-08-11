extends "res://ui/msgBase/msgBase.gd"

onready var txt = $RichTextLabel

func _ready():
	Steam.connect("leaderboard_scores_downloaded", self, "_leaderboard_scores_downloaded")
	
	Steam.downloadLeaderboardEntries(0, 100)
	print("获取玩家排行")
	yield(Steam, "clan_activity_downloaded")
	
	txt.bbcode_text += "%30s%30s%30s\n" % ["排名", "得分", "玩家"]
	for i in Steam.getLeaderboardEntries():
		txt.bbcode_text += "%30s%30s%30s\n" % [i["global_rank"], i["score"], Steam.getFriendPersonaName(i["steamID"])]

func _leaderboard_scores_downloaded(a, b):
	var ids = []
	var infos = Steam.getLeaderboardEntries()


	
	txt.bbcode_text += "%30s%30s%30s\n" % ["排名", "得分", "玩家"]
	for i in Steam.getLeaderboardEntries():
		var uname = Steam.getFriendPersonaName(i["steamID"]).to_ascii().get_string_from_utf8()
		txt.bbcode_text += "%30s%30s%30s\n" % [i["global_rank"], i["score"], uname]
		
func _on_Button_pressed():
	queue_free()
	pass

