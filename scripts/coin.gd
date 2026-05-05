extends Area2D

# 金幣被收集時的信號
signal coin_collected

func _ready():
	# 連接碰撞信號
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	"""當玩家接觸到金幣時"""
	if body.name == "Player":
		coin_collected.emit()
		queue_free()  # 刪除金幣