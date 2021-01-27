extends TileMap

var CHECK = true
var name_of_tile
var value = Vector2(0, 0)
func get_tile():
	if CHECK == true:
		var pos = world_to_map(value)
		name_of_tile = get_cellv(pos)
		print(name_of_tile)
		#CHECK = false

func _process(delta):
	get_tile()
