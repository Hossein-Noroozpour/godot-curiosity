extends Area2D

signal hit

export var speed = 400
var screen_size


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2()
	var is_moving = false
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = false
		is_moving = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = true
		is_moving = true
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = true
		is_moving = true
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = false
		is_moving = true
	if is_moving:
		velocity = velocity.normalized() * speed
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
