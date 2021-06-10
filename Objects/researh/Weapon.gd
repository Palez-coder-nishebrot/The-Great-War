extends Node2D

func _ready():
	get_node("Исследования Лебеля").tipe = 'AvtWepon'
	get_node("Исследования Лебеля").status = true
	
	get_node("Винтовка Токарева").tipe = 'PolAvtWepon'
	get_node("Винтовка Токарева").status = true
