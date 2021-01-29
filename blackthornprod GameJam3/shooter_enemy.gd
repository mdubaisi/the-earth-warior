extends KinematicBody2D

onready var player = get_parent().get_node("player")
onready var shoot_timer = $shoot_timer
const BULLET = preload("res://enemy_bullet.tscn")
const ITEM = preload("res://item.tscn")
export(int) var health = 30
var speed
var cur_health = health
var dead = false
var created = false
var i: int

func _ready():
	randomize()
	i = randi() % 2
	if i == 1:
		i = randi() % 2
	speed = rand_range(60, 100)
	shoot_timer.wait_time = rand_range(1.25, 2.5)
	shoot_timer.start()

func _physics_process(delta):
	if cur_health <= 0:
		dead = true
	if !dead:
		global_position.y += speed * delta
	else:
		speed = 0
		$Sprite.visible = false
		global.create_child(global.EXPLOSION, self.global_position, self)
		if i == 1 and !created:
			created = true
			global.create_child(ITEM, self.global_position, get_parent())

func take_damage():
	$AnimationPlayer.play("take_damage")

func _on_shoot_timer_timeout():
	global.create_child(BULLET, self.global_position + Vector2(0, 16), get_parent())
	$sound.play()
	shoot_timer.wait_time = rand_range(1.25, 2.5)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
