extends Node2D

func _on_Quit_game_pressed():
	get_tree().quit()
func _on_Quit_menu_pressed():
	get_tree().change_scene("res://SCN/Menu.tscn")
func _on_Continue_pressed():
	visible = false
func _on_Setttings_pressed():
	print('settings')
