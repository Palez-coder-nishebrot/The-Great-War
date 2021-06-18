extends Node2D

const contries: Array = ["Республика Адамантия", "Империя Баскакия", 'Социалистическая Народная Республика Баскакия', 'Народная Республика Горния', 'Легион Насардия']

func _on_Button_pressed():
	spawn_buttons_for_set_country()

func spawn_buttons_for_set_country():
	$Button.visible = false
	var pos:Vector2 = Vector2(419, 217)
	for i in 5:
		var object = load("res://Buttons/Set_country.tscn").instance()
		object.rect_position = pos
		object.text = contries[i]
		pos.y += 89
		add_child(object)
		
func start_game(country):
	get_node("/root/PlayersObj").start_country_for_player = country
	get_tree().change_scene("res://SCN/Game.tscn")

