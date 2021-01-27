extends Node2D

var City = load("res://Objects/City.tscn")
var token = 0
signal city_spawn(obj)
func _on_Timer_timeout():
	token += 1
	if token != 2:
		get_node("Timer").start(4096)
		
func _ready():
	spawnCity(Vector2(407, 215), 'a', 140, 'country', 'Rawnina', "none")
	spawnCity(Vector2(794, 263), 'b', 140, 'country', 'Korolewstvo Istland', "none")
	spawnCity(Vector2(1175, 551), 'c', 140, 'country', 'Istland Protectorat', "none")
	spawnCity(Vector2(839, 791), 'd', 40, 'usually', 'Sausenya', "factory")
	spawnCity(Vector2(262, 503), 'f', 20, 'usually', 'Beregowot Korolestwo', "none")
	
	
	spawnCity(Vector2(214, 119), 'g', 20, 'usually', 'Rawnina', "none")
	spawnCity(Vector2(552, 72), 'w', 40, 'usually', 'Rawnina', "none")
	
	spawnCity(Vector2(1175, 71), "q", 20, 'country', 'Korolewstvo Istland', "none")
	spawnCity(Vector2(984, 168), "y", 40, 'country', 'Korolewstvo Istland', "none")
	
	spawnCity(Vector2(697, 502), 't', 20, 'usually', 'Istland Protectorat', "none")
	spawnCity(Vector2(935, 504), 'l', 40, 'usually', 'Istland Protectorat', "none")
	
	spawnCity(Vector2(1127, 935), 'k', 20, 'usually', 'Sausenya', "none")
	spawnCity(Vector2(936, 983), 'j', 40, 'usually', 'Sausenya', "none")
	
	spawnCity(Vector2(360, 647), 'g', 20, 'usually', 'Beregowot Korolestwo', "none")
	spawnCity(Vector2(745, 1079), 'u', 40, 'usually', 'Beregowot Korolestwo', "none")
	
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
