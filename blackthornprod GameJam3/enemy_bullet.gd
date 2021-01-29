extends Area2D

export(int) var speed = 230
export(int) var damage = 15
onready var player = get_parent().get_node("player")

func _physics_process(delta):
	global_position.y += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_enemy_bullet_body_entered(body):
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

func _on_enemy_bullet_area_entered(area):
	if area.name == "earth":
		area.cur_health -= damage
		global.create_child(global.EXPLOSION, self.global_position, self)
		$Sprite.visible = false
		speed = 0
