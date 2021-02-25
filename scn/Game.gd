extends Node2D

var City = load("res://Objects/City.tscn")
var token = 0
var time_of_game = {
"day": 1,
"month": 1,
"year": 1918
}
var object_in_mouse_area = null
var month_list = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
signal city_spawn(obj)
signal timeout

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if get_node("Time_of_game").paused == false:
			get_node("Time_of_game").paused = true
		else:
			get_node("Time_of_game").paused = false
			
	get_node("mouse").position = get_global_mouse_position()
func _ready():
	spawnCity(Vector2(407, 215), 'a', 140, 'country', 'Adamanty', "none")
	spawnCity(Vector2(794, 263), 'b', 140, 'country', 'Tsarstvo Bascany', "none")
	spawnCity(Vector2(1175, 551), 'c', 140, 'country', 'Bascany Protectorat', "none")
	spawnCity(Vector2(839, 791), 'd', 40, 'country', 'Gorny', "factory")
	spawnCity(Vector2(262, 503), 'f', 20, 'country', 'Nasadry', "none")
	
	
	spawnCity(Vector2(214, 119), 'g', 20, 'usually', 'Adamanty', "none")
	spawnCity(Vector2(552, 72), 'w', 40, 'usually', 'Adamanty', "none")
	
	spawnCity(Vector2(1175, 71), "q", 20, 'country', 'Tsarstvo Bascany', "none")
	spawnCity(Vector2(984, 168), "y", 40, 'country', 'Tsarstvo Bascany', "none")
	
	spawnCity(Vector2(697, 502), 't', 20, 'usually', 'Bascany Protectorat', "none")
	spawnCity(Vector2(935, 504), 'l', 40, 'usually', 'Bascany Protectorat', "none")
	
	spawnCity(Vector2(1127, 935), 'k', 20, 'usually', 'Gorny', "none")
	spawnCity(Vector2(936, 983), 'j', 40, 'usually', 'Gorny', "none")
	
	spawnCity(Vector2(360, 647), 'g', 20, 'usually', 'Nasadry', "none")
	spawnCity(Vector2(745, 1079), 'u', 40, 'usually', 'Nasadry', "none")
	
	get_node("Timer_fo_tiles").start(1)
	set_parties()

func set_parties():
	var tk = 6
	var party = get_node("/root/Global").parties_for_randi
	for i in tk:
		var r = rand_range(1, 14)
		r = int(r)
		var p = party.get(r)
		if p in party:
			print("hehe :)")
			tk += 1
		else:
			get_node("Player").parties[i] = [p[0], p[1], 10]
func spawnCity(pos, NameF, populationF, Tipe, PartOf, build):
	var obj = City.instance()
	obj.position = pos
	obj.Name = NameF
	obj.population = populationF
	obj.tipe = Tipe  
	obj.partOf = PartOf
	obj.build.append(build)
	emit_signal("city_spawn", obj)
	call_deferred("add_child", obj)
func _on_RESP_body_entered(body):
	body.partOf = "Adamanty"
	get_node("CZ").queue_free()
func _on_KOROLEV_body_entered(body):
	body.partOf = "Tsarstvo Bascany"
	get_node("BEREG").queue_free()
func _on_PROT_body_entered(body):
	body.partOf = "Bascany Protectorat"
	get_node("PROT").queue_free()
func _on_BEREG_body_entered(body):
	body.partOf = "Nasadry"
	get_node("KOROLEV").queue_free()
func _on_CZ_body_entered(body):
	body.partOf = "Gorny"
	get_node("RESP").queue_free()
func _on_Timer_fo_tiles_timeout():
	emit_signal("timeout")
	get_node("Timer_fo_tiles").stop()

func _on_Time_of_game_timeout():
	if time_of_game["day"] == 31:
		time_of_game["day"] = 1
		time_of_game["month"] += 1
		if time_of_game["month"] > 12:
			time_of_game["month"] = 1
			time_of_game["year"] += 1
	else:
		time_of_game["day"] += 1
	var day = str(time_of_game["day"])
	var month = month_list[time_of_game["month"] - 1]
	var year = str(time_of_game["year"])
	get_node("Player/CanvasLayer/time").text = "День: " + day + "\n Месяц: " + month + "\n Год: " + year
		
func _on_mouse_body_entered(body):
	if body.BODY == "TILE":
		object_in_mouse_area = body.partOf
