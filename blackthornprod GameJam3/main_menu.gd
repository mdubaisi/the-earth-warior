extends Control


func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	var c = get_tree().change_scene("res://World.tscn")
	c = c
