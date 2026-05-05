extends Node

# 遊戲變數
var score = 0
var coins_collected = 0
var max_coins = 0

# UI 節點
@onready var score_label = $CanvasLayer/ScoreLabel
@onready var coins_label = $CanvasLayer/CoinsLabel

func _ready():
	# 計算金幣總數
	max_coins = get_tree().get_nodes_in_group("coins").size()
	update_ui()

func add_score(points: int):
	"""增加分數"""
	score += points
	coins_collected += 1
	update_ui()

func update_ui():
	"""更新 UI 顯示"""
	if score_label:
		score_label.text = "分數: " + str(score)
	
	if coins_label:
		coins_label.text = "金幣: " + str(coins_collected) + "/" + str(max_coins)
	
	# 檢查是否收集完所有金幣
	if coins_collected == max_coins and max_coins > 0:
		print("🎉 恭喜！您收集了所有金幣！")
		print("最終分數: " + str(score))