extends Node

var AvtWeponSlot
var PolAvtWeponSlot
func _ready():
	get_node("Исследования Лебеля").tipe = 'AvtWepon'
	get_node("Исследования Лебеля").status = true
	AvtWeponSlot = get_node("Исследования Лебеля")
	
	get_node("Винтовка Токарева").tipe = 'PolAvtWepon'
	get_node("Винтовка Токарева").status = true
	PolAvtWeponSlot = get_node("Винтовка Токарева")
