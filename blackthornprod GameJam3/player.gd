extends KinematicBody2D

const BULLET = preload("res://player_bullet.tscn")
onready var earth = get_parent().get_node("earth")
export(int) var speed = 75
export(int) var health = 150
var velocity = Vector2.ZERO
var cur_health = health
var can_shoot = true
var dead = false

func _physics_process(_delta):
	# movement and shooting
	if cur_health <= 0 and !dead:
		dead = true
		speed = 0
		$Sprite.visible = false
		global.create_child(global.EXPLOSION, self.global_position, self)
	else:
		if Input.is_action_pressed("left"):
			velocity.x -= speed
		if Input.is_action_pressed("right"):
			velocity.x += speed
		if Input.is_action_pressed("shoot") and can_shoot and !dead:
			$sound.play()
			global.create_child(BULLET, self.global_position - Vector2(0, 16), get_parent())
			can_shoot = false
			$can_shoot_timer.start()
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.x = lerp(velocity.x, 0, 0.13)

func take_damage():
	$AnimationPlayer.play("take_damage")

func speed_bullets_refill():
	$can_shoot_timer.wait_time = 0.4
	yield(get_tree().create_timer(rand_range(2, 3)), "timeout")
	$item_done.play()
	$can_shoot_timer.wait_time = 0.8

func _on_can_shoot_timer_timeout():
	can_shoot = true
