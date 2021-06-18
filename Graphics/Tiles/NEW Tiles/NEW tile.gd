extends Node2D

#const r = 'Rawnina'
#const Name = "Sprite"
var number_for_name = 1
var pos_of_gex = Vector2(0, 0)
var X = pos_of_gex.x
var how_much_in_line = 0
var token = 1
const R = 12#12
const C = 12#12
const K = 120

signal new_tile(SELF)

var gex = load("res://tiles/NEW Tiles/Sprite.tscn")
func _ready():
	for _i in range(R):
		for _y in range(C):
			if token == C:
				pos_of_gex.x += K #112
				spawn_gex(pos_of_gex)
				pos_of_gex.y += K
				pos_of_gex.x = X
				token = 0
			else:
				pos_of_gex.x += K
				spawn_gex(pos_of_gex)
			token = token + 1
	#for row in range(R):
		#for col in range(C):
			#if col%2 != 0:
				#pos_of_gex.x = (112*row) + 56
				#pos_of_gex.y = (112*col) - (30 * col)
			#else:
				#pos_of_gex.x = 112*row
				#pos_of_gex.y = (112*col) - 30*col
				
			#spawn_gex(pos_of_gex)
func spawn_gex(pos):
	var obj = gex.instance()
	obj.position = pos
	add_child(obj)
	emit_signal("new_tile", obj)
	

