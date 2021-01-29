extends Area2D

export(int) var speed = 400
export(int) var damage = 20

func _physics_process(delta):
	global_position.y -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_player_bullet_body_entered(body):
	if !body.dead:
		if body.cur_health - damage > 0:
			body.take_damage()
			$sound.play()
			body.cur_health -= damage
			speed = 0
			yield($sound, "finished")
			queue_free()
		else:
			body.cur_health -= damage
			speed = 0
			queue_free()

func _on_player_bullet_area_entered(area):
	area.speed = 0
	global.create_child(global.EXPLOSION, self.global_position, area)
