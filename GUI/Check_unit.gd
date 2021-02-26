extends Node2D

var array_of_buttons = []
onready var weapon_podd_list = get_node("/root/Global")
var SELF 
var what_the_button_click
var name_button 


func _on_weapon_pressed():
	name_button = "weapon"
	func_for_spawn_button(get_parent().get_parent().warehouse_of_weapon)
	what_the_button_click = "weapon"

func func_for_spawn_button(warehouse):
	for i in array_of_buttons:
		i.queue_free()
	array_of_buttons.clear()
	var pos = Vector2(100, -30)
	for i in warehouse:
		if warehouse[i] > 0:
			spawn_button(pos, i)
			pos.y += 31
	pos.y += 31

func spawn_button(pos, text):
	var obj = load("res://Buttons/Button_for_check_unit.tscn").instance()
	obj.rect_position = pos
	obj.rect_size = Vector2(130, 31)
	obj.text = text
	obj.visible = true
	obj.connect("click", self, "On_button_pressed")
	add_child(obj)
	array_of_buttons.append(obj)

func On_button_pressed(Text):
	print("Button TEXT")
	if Text in get_node("/root/ListWeaponsTech").tipe_of_objects:
		SELF.append_obj_for_inventory(Text, what_the_button_click, name_button)
func check_unit(_SELF, hp, attak, weapon, weapon_for_podd1, weapon_for_podd2, ammo1, ammo2, tech, podd):
	SELF = _SELF
	visible = true
	$hp.text = "Урон: " + str(hp)
	$Attak.text = "Живучесть: " + str(attak)
	$weapon.text = weapon
	$ammo1.text = ammo1
	$ammo2.text = ammo2
	$tech.text = tech
	$pod.text = weapon_for_podd1
	$pod2.text = weapon_for_podd2
	$podd.text = podd
	print(weapon, " ", podd)
func _on_exit_pressed():
	visible = false

func _on_podd_pressed():
	name_button = "podd"
	func_for_spawn_button(get_parent().get_parent().warehouse_of_podd)
	what_the_button_click = "podd"
	
func _on_ammo1_pressed():
	name_button = "ammo1"
	func_for_spawn_button(get_parent().get_parent().warehouse_of_ammo)
	what_the_button_click = "ammo"

func _on_ammo2_pressed():
	name_button = "ammo2"
	func_for_spawn_button(get_parent().get_parent().warehouse_of_ammo)
	what_the_button_click = "ammo"
	
func _on_pod_pressed():
	name_button = "weapon_podd1"
	func_for_spawn_button(get_parent().get_parent().warehouse_of_weapon_for_podd)
	what_the_button_click = "weapon_for_podd"

func _on_pod2_pressed():
	name_button = "weapon_podd2"
	func_for_spawn_button(get_parent().get_parent().warehouse_of_weapon_for_podd)
	what_the_button_click = "weapon_for_podd"

func _on_tech_pressed():
	name_button = "tech"
	func_for_spawn_button(get_parent().get_parent().warehouse_of_tech)
	what_the_button_click = "tech"
