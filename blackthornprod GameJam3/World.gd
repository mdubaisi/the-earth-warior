extends Node2D

const LOSE_SCREEN = preload("res://lose_screen.tscn")
const DESTROY_SCREEN = preload("res://destroy_screen.tscn")
onready var player = get_node("player")
onready var earth = get_node("earth")
onready var enemy_timer = $enemy_spawn_timer
export(Array, PackedScene) var enemies: Array
var time_to_spawn
var p_lost = false
var e_destroyed = false
signal player_lost
signal earth_destroyed

func _ready():
	randomize()

func _physics_process(_delta):
	time_to_spawn = max(2, min(player.cur_health / 30, earth.cur_health / 40))
	enemy_timer.wait_time = time_to_spawn
	if player.cur_health <= 0 and !p_lost:
		p_lost = true
		emit_signal("player_lost")

func _on_enemy_spawn_timer_timeout():
	if !p_lost and !e_destroyed:
		enemies.shuffle()
		var enemy: PackedScene = enemies.front()
		var enemy_pos = Vector2(rand_range(20, 600), -50)
		global.create_child(enemy, enemy_pos, self)

func _on_earth_dead():
	if !e_destroyed:
		e_destroyed = true
		emit_signal("earth_destroyed")

func _on_World_earth_destroyed():
	get_tree().paused = true
	global.create_child(DESTROY_SCREEN, self.global_position, $CanvasLayer)

func _on_World_player_lost():
	get_tree().paused = true
	global.create_child(LOSE_SCREEN, self.global_position, $CanvasLayer)
