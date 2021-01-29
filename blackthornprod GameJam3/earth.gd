extends Area2D

export(int) var health = 200
var cur_health = health
signal dead

func _physics_process(_delta):
	if cur_health <= 0:
		emit_signal("dead")

func _on_earth_body_entered(body):
	body.cur_health -= 15
