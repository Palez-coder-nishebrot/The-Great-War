extends Node2D

var City = load("res://Objects/City.tscn")
var token = 0
signal city_spawn(obj)
signal timeout
		
func _ready():
	spawnCity(Vector2(407, 215), 'a', 140, 'country', 'Adamanty', "none")
	spawnCity(Vector2(794, 263), 'b', 140, 'country', 'Tsarstvo Bascany', "none")
	spawnCity(Vector2(1175, 551), 'c', 140, 'country', 'Bascany Protectorat', "none")
	spawnCity(Vector2(839, 791), 'd', 40, 'usually', 'Gorny', "factory")
	spawnCity(Vector2(262, 503), 'f', 20, 'usually', 'Nasadry', "none")
	
	
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
		var r = rand_range(1, 12)
		r = int(r)
		var p = party.get(r)
		if p in party:
			print("hehe :)")
			tk += 1
		else:
			get_node("Player").parties[i] = [p[0], p[1]]
	#print(get_node("Player").parties)
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
