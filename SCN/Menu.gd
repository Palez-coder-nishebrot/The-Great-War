extends Node2D

const contries = ["Адамантия", "Насардия", 'Социалистическая Республика Баскакия', 'Горния', 'Царство Баскакия']

func _on_Button_pressed():
	spawn_buttons_for_set_country()

func spawn_buttons_for_set_country():
	var pos = Vector2(419, 217)
	for i in 5:
		var object = load("res://Buttons/Set_country.tscn").instance()
		object.rect_position = pos
		object.text = contries[i]
		pos.y += 42
		add_child(object)
		
func start_game(country):
	get_node("/root/Global").start_contry_for_player = country
	get_tree().change_scene("res://SCN/Game.tscn")
