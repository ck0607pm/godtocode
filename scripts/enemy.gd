extends CharacterBody2D

# 敵人速度
var speed = 150
var player: Node2D = null
var is_chasing = false

func _ready():
	# 查找玩家
	player = get_tree().root.get_node("Main/Player")

func _physics_process(delta):
	if player == null:
		return
	
	# 計算玩家方向
	var direction = (player.global_position - global_position).normalized()
	
	# 設置速度
	velocity = direction * speed
	
	# 移動敵人
	move_and_slide()

func _on_body_entered(body):
	"""敵人碰到玩家時"""
	if body.name == "Player":
		print("遊戲結束！被敵人抓到了！")
		get_tree().reload_current_scene()