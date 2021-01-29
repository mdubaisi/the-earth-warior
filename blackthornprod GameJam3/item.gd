extends Area2D

export(int) var fall_speed = 150

func _physics_process(delta):
	global_position.y += fall_speed * delta

func _on_item_body_entered(body):
	body.speed_bullets_refill()
	$sound.play()
	yield($sound, "finished")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
