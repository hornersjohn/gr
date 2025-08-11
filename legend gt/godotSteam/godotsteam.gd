
var on = false
signal on_item_created()
signal on_item_updated()
signal onUpEnd()

func _ready():
	pass

func init():
	print("steam初始化")
	var INIT = Steam.steamInit()
	print(INIT)
	if INIT["status"] != 1:
		sys.get_tree().quit()
		pass
	on = true
	var fenzhi = Steam.getCurrentBetaName()
	
	if fenzhi == "123456123456":
		sys.test = true
	Steam.connect("leaderboard_find_result", self, "_leaderboard_find_result")
	Steam.connect("leaderboard_score_uploaded", self, "_leaderboard_uploaded")
	Steam.connect("item_created", self, "_item_created")
	Steam.connect("item_updated", self, "_item_updated")
	Steam.findLeaderboard("tongGuan")
	
	

func _leaderboard_find_result(aa, bb):
	print_debug("接入排行榜")

func _leaderboard_uploaded(a, b, c, d, f):
	print_debug("上传得分")

func _process(delta):
	Steam.run_callbacks()
	
func getSteamUILanguage():
	return Steam.getSteamUILanguage()

func upScore(val):
	if on == false: return
	Steam.uploadLeaderboardScore(val, true)

func createItem():
	Steam.createItem(Steam.getAppID(), 0)
var nowItemId
func _item_created(m_eResult, m_nPublishedFileId, m_bUserNeedsToAcceptWorkshopLegalAgreement):
	nowItemId = m_nPublishedFileId
	print_debug(nowItemId)
	if m_eResult == 1:
		print_debug("创建物品成功 id:%s" % nowItemId)
	else:
		print_debug("创建物品失败", m_eResult)
	emit_signal("on_item_created")

func itemUpdate(id, tile, info, dir, png):
	var h = Steam.startItemUpdate(Steam.getAppID(), id)
	
	Steam.setItemTitle(h, tile)
	Steam.setItemDescription(h, info)
	Steam.setItemUpdateLanguage(h, "english")
	
	Steam.setItemVisibility(h, 0)
	
	
	
	
	
	Steam.setItemContent(h, dir)
	Steam.setItemPreview(h, png)

	Steam.submitItemUpdate(h, "")

	

func item_Up(id, tile, info, dir, png):
	if id != null:
		nowItemId = id
		itemUpdate(id, tile, info, dir, png)
	else:
		createItem()
		yield(self, "on_item_created")
		itemUpdate(nowItemId, tile, info, dir, png)
		print("等待更新")
		yield(self, "on_item_updated")
		if true:
			var file = File.new()
			var dic = {
				id = nowItemId, 
				tile = tile, 
				info = info, 
				dir = dir, 
				png = png
			}
			file.open(dir + "/itemId.dic", File.WRITE)
			file.store_line(to_json(dic))
			file.close()
		else:
			Steam.deleteItem(nowItemId)
	emit_signal("onUpEnd")

var isUpdata = false
func _item_updated(m_eResult, m_bUserNeedsToAcceptWorkshopLegalAgreement):
	if m_eResult == 1:
		print_debug("更新物品成功")
		isUpdata = true
		Steam.activateGameOverlayToWebPage("steam://url/CommunityFilePage/%d" % nowItemId)
		sys.newBaseMsg("提示", "物品上传成功。id:%s" % nowItemId)
	else:
		print_debug("更新物品失败", m_eResult)
		isUpdata = false
		sys.newBaseMsg("提示", "物品上传失败。id:%s" % nowItemId)
	emit_signal("on_item_updated")

func ach(id):
	if on:
		Steam.setAchievement(id)
			
func loadMod():
	var dir = Directory.new()
	var dirStr = Steam.getAppInstallDir(Steam.getAppID()) + "/cache"
	dir.make_dir_recursive(dirStr)
	print("载入测试mod")
	dir = Directory.new()
	dirStr = Steam.getAppInstallDir(Steam.getAppID()) + "/mods"
	dir.make_dir_recursive(dirStr)
	sys.loadEx(dirStr)
	
	for i in Steam.getSubscribedItems():
		var id = str(i)
		var bl = true
		if modData.infoDs.has(id):
			bl = modData.infoDs[id]
		if bl:
			var dc = Steam.getItemInstallInfo(i)
			sys.loadEx(dc["folder"])
