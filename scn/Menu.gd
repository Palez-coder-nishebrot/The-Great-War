extends Node2D

func _on_Button_pressed():
	exit_menu()

func exit_menu():
	get_node("Button3").connect("start", self, "START")
	get_node("Button").visible = false
	get_node("Button2").visible = false
	get_node("Button3").visible = true
	spawn_button_for_country()
	
func spawn_button_for_country():
	var c = get_node("/root/Global").contries
	var start_pos = get_node("Button3").rect_position
	var plus = 56
	for i in c:
		start_pos = Vector2(start_pos.x, start_pos.y + plus)
		var obj = get_node("Button3").duplicate()
		obj.connect("start", self, "START")
		obj.text = i
		obj.rect_position = start_pos
		add_child(obj)

func START(TEXT):
	get_node("/root/Global").for_start = TEXT
	get_tree().change_scene("res://scn/Game.tscn")
