extends Control

func _on_restart_pressed():
	get_tree().paused = false
	var r = get_tree().reload_current_scene()
	r = r

func _on_main_menu_pressed():
	get_tree().paused = false
	var c = get_tree().change_scene("res://main_menu.tscn")
	c = c

func _on_quit_pressed():
	get_tree().quit()
