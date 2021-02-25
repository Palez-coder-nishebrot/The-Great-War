extends Node2D

var TIME = 3
var tipe
var unit

func _ready():
	get_node("Timer").start(TIME)


func _on_Timer_timeout():
	if tipe == "tech":
		get_parent().warehouse_of_tech[unit] += 1
	elif tipe == "infantry":
		get_parent().spawn_unit()
	if tipe in get_parent().warehouse_of_weapon:
		get_parent().warehouse_of_weapon[tipe] += 1
		print(get_parent().warehouse_of_weapon)
	elif tipe in get_parent().warehouse_of_podd:
		get_parent().warehouse_of_podd[tipe] += 1
		print(get_parent().warehouse_of_podd)
	elif tipe in get_parent().warehouse_of_ammo:
		get_parent().warehouse_of_ammo[tipe]  += 1
		print(get_parent().warehouse_of_ammo)
	elif tipe in get_parent().warehouse_of_weapon_for_podd:
		get_parent().warehouse_of_weapon_for_podd[tipe] += 1
		print(get_parent().warehouse_of_weapon_for_podd)
	queue_free()
