extends CharacterBody2D

# 移動速度
var speed = 300
var max_speed = 400

# 跳躍
var jump_force = -400  # 負數表示向上
var gravity = 800
var is_jumping = false

# 動畫
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# 左右移動（手把控制）
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 水平移動
	velocity.x = input_vector.x * speed
	
	# 垂直移動（重力和跳躍）
	if is_on_floor():
		is_jumping = false
		# 檢測跳躍輸入（按空白鍵或手把按鈕）
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_force
			is_jumping = true
	else:
		# 應用重力
		velocity.y += gravity * delta
	
	# 移動角色
	move_and_slide()
	
	# 更新動畫
	_update_animation(input_vector)

func _update_animation(input_vector):
	"""更新角色動畫"""
	
	# 檢查是否有動畫播放器
	if animated_sprite == null:
		return
	
	# ��躍時播放跳躍動畫
	if is_jumping:
		animated_sprite.play("jump")
		return
	
	# 移動時播放走路動畫
	if input_vector.x != 0:
		animated_sprite.play("walk")
		# 根據方向翻轉角色
		if input_vector.x < 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	else:
		# 停止時播放站立動畫
		animated_sprite.play("idle")
