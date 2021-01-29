extends Node

const EXPLOSION = preload("res://explosion.tscn")

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func create_child(obj: PackedScene, pos: Vector2, parent: Node) -> void:
	var object = obj.instance()
	parent.add_child(object)
	if object is Node2D:
		object.global_position = pos
	else:
		object.rect_position = pos
		object.rect_size = Vector2(640, 800)
