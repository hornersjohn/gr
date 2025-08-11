extends Node

const fixDef = 0.5
const fixDefDuck = 1.0
const fixDexCrit = 1.0
const fixCrit = 2
const fixDuck = 0.5

const chaGold = 67

const itemNamesARMS1 = ["生锈", "新兵", "精铁", "钨钢", "碎骨"]
const itemNamesJEW1 = ["青铜", "白瓷", "丝绸", "狼骨", "暗夜"]
const itemNamesBODY1 = ["简易皮革", "羊皮", "鹿皮", "狼皮", "红星"]
const itemNamesSWORD2 = ["长剑", "重剑", "巨剑", "剑"]
const itemNamesDUAL2 = ["双刃", "双剑", "匕首"]
const itemNamesJEW2 = ["戒子", "手镯", "护腕", "护符", "吊坠"]
const itemNamesBODY2 = ["背心", "长袍", "重铠", "胸甲", "外套"]

var itemTabs = {arms = "武器", equi = "防具", body = "饰品"}

const surNameStrs = ["张", "李", "王", "刘", "陈", "杨", "周", "吴", "苏"]
const nameStrs = ["小红", "小明", "小绿", "小白", "雨", "云", "备", "飞", "义"]

const gattStrs = ["力量", "体质", "敏捷", "智力", "魅力", "运气"]
const itemGradeColors = ["#efefef", "#62b6f0", "#d262f0", "#f0e862"]
const itemGradeStrs = ["普通", "精良", "卓越", "史诗", "传说"]

enum {EQUITYPE_EQUI, EQUIETYPE_PASS}

const attKeys = ["maxHp", "atk", "def", "mgiAtk", "mgiDef", "pen", "mgiPen", "atkRan", "cri", "criR", "suck", "mgiSuck", "reHp", "spd", "cd", "dod", "reHpM", "atkR", "defR", "maxHpL", "atkL", "defL", "mgiAtkL", "mgiDefL", "penL", "mgiPenL"]

const attStrs = ["最大生命值", "物理攻击", "物理防御", "魔法强度", "魔法防御", "物理穿透", "魔法穿透", "攻击范围", "暴击率", "暴击伤害增加", "物理吸血", "魔法吸血", "治疗效果", "攻击速度", "冷却充能速度", "闪避", "释放治疗效果", "伤害加成", "承受伤害减少", "最大生命值", "物理攻击", "物理防御", "魔法攻击", "魔法防御", "物理穿透", "魔法穿透"]

var bfDir = {
	"失明": "普通攻击30%概率miss，每层额外增加3%，每秒减少层数。", 
	"急速": "增加20%攻击速度，每层额外增加2%，每秒减少层数。", 
	"狂怒": "增加20%攻击力，每层额外增加2%，每秒减少层数。", 
	"烧灼": "每秒减少1%的生命值，每层额外增加0.1%，每秒减少层数。", 
	"中毒": "减少10%双抗和治疗效果，每层额外1%;每秒减少层数。", 
	"流血": "被攻击额外承受30%伤害,每层额外增加3%，每秒减少层数。", 
	"结霜": "减少30%攻击速度和冷却速度，每层额外减少3%，每秒减少层数。", 
	"抵御": "增加20%物理防御，每层额外增加2%，每秒减少层数。", 
	"魔御": "增加20%魔法防御，每层额外增加2%，每秒减少层数。", 
}

var attRds = {
	atkL = "atk", 
	defL = "def", 
	mgiAtkL = "mgiAtk", 
	mgiDefL = "mgiDef", 
	maxHpL = "maxHp"
}

var attRdsKeys = attRds.keys()
var attRdsVals = attRds.values()
