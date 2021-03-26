extends Node2D
func _ready():
	set_parties()
	var COW = 12
	var COL = 12
	var K = 200
	var pos_of_tile = Vector2(0, 0)
	var X = pos_of_tile.x
	var token = 1
	for _i in COW:
		for _y in COL:
			if token == COL:
				pos_of_tile.x += K
				spawn_tile(pos_of_tile)
				pos_of_tile.y += K
				pos_of_tile.x = X
				token = 0
			else:
				pos_of_tile.x += K
				spawn_tile(pos_of_tile)
			token = token + 1
func spawn_tile(pos):
	var obj = load("res://Objects/tiles/Tile.tscn").instance()
	obj.position = pos
	add_child(obj)
func _on_Area2D_body_entered(body):
	body.part_of = "Насардия"
	get_node("Nasardy").queue_free()
func _on_Gorny_body_entered(body):
	body.part_of = "Горния"
	get_node("Gorny").queue_free()
func _on_Bascany_body_entered(body):
	body.part_of = "Баскакия"
	get_node("Bascany").queue_free()
func _on_Tsarstvo_Bascany_body_entered(body):
	body.part_of = "Царство Баскакия"
	get_node("Tsarstvo_Bascany").queue_free()
func _on_Adamanty_body_entered(body):
	body.part_of = "Адамантия"
	get_node("Adamanty").queue_free()
func _on_Timer_timeout():
	var obj = load("res://Objects/units/Unit.tscn").instance()
	obj.position = Vector2(712, 296)
	add_child(obj)
	get_node("Timer").queue_free()


func set_parties():
	var variant_party = get_node("/root/DataBase").parties
	var num = 8.0
	for i in range(4):
		var party = set_party(num)
		var tipe_of_party = party[0]
		var name_of_party = party[1]
		name_of_party = get_node("/root/DataBase").parties.get(tipe_of_party)[name_of_party]
		$Player.parties[tipe_of_party] = name_of_party
		variant_party.erase(party[0])
		num -= 1.0
		
func set_party(num):
	var tipe_of_party = rng(0.0,num)
	var name_of_party = rng(0.0, 2.0)
	var remove = tipe_of_party
	tipe_of_party = get_node("/root/DataBase").tipe_ide[tipe_of_party]
	get_node("/root/DataBase").tipe_ide.remove(remove)
	return [tipe_of_party, name_of_party]

func rng(num1,num2):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(num1,num2)
	return int(my_random_number)
