extends Node2D

func _ready():
	var X = 190
	var Y = 160
	var pos_s = Vector2(0, 0)
	var pos = Vector2(0, 0)
	for i in range(7):
		for u in range(12):
			var hex = load("res://Objects/tiles/Tile.tscn").instance()
			hex.position = pos
			TileMapReg.position_to_tile[pos] = hex
			add_child(hex)
			pos.x += X
		pos.y += Y
		pos.x = pos_s.x - 100
		for u in range(12):
			var hex = load("res://Objects/tiles/Tile.tscn").instance()
			hex.position = pos
			TileMapReg.position_to_tile[pos] = hex
			add_child(hex)
			pos.x += X
		pos.x = pos_s.x 
		pos.y += Y
		
	$Nasardy.monitoring = true
	$Adamanty.monitoring = true
	$Gorny.monitoring = true
	$Bascaky_C.monitoring = true
	$Bascaky_Ts.monitoring = true
	yield(get_tree().create_timer(1.0), "timeout")
	$Nasardy.queue_free()
	$Adamanty.queue_free()
	$Gorny.queue_free()
	$Bascaky_C.queue_free()
	$Bascaky_Ts.queue_free()




func _on_Bascaky_Ts_area_entered(area):
	check('Империя Баскакия', area)
func _on_Bascaky_C_area_entered(area):
	check('Социалистическая Народная Республика Баскакия', area)
func _on_Gorny_area_entered(area):
	check('Народная Республика Горния', area)
func _on_Nasardy_area_entered(area):
	check('Легион Насардия', area)
func _on_Adamanty_area_entered(area):
	check('Республика Адамантия', area)
	
func check(partOf, object):
	object.get_parent().sprite_object.modulate = PlayersObj.playersObj[partOf][0]
	object.get_parent().part_of = partOf
