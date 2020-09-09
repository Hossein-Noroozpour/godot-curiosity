extends Area2D

signal hit

export var speed = 400
var screen_size
var target = Vector2()
var is_moving = false


func _ready():
	screen_size = get_viewport_rect().size


func _input(event):
	if event is InputEventScreenTouch:
		is_moving = event.pressed
		target = event.position
	if event is InputEventScreenDrag:
		target = event.position


func _process(delta):
	if is_moving:
		var direction = target - position
		var distance = direction.length()
		if distance < 10:
			$AnimatedSprite.stop()
			return
		var delta_pos = direction * (delta * speed / distance)
		position += delta_pos
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		if abs(delta_pos.x) > abs(delta_pos.y): 
			$AnimatedSprite.animation = "walk"
		else:
			$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_h = delta_pos.x > 0.0
		$AnimatedSprite.flip_v = delta_pos.y > 0.0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()


func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	target = pos
	is_moving = false
	show()
	$CollisionShape2D.disabled = false
