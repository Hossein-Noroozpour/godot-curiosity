extends CanvasLayer

signal start_game


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$Message.text = "Dodge\nthe\nCreeps!"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().call_group("mobs", "queue_free")
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")