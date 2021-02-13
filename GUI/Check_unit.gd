extends Node2D

var weapon = "None"
var dop_weapon = null
var ammo = null
onready var weapon_podd_list = get_node("/root/Global")

#var players_ammo = get_parent().warehouse_of_ammo.get("ammo_for_gun")
#var players_whizzbang = get_parent().warehouse_of_ammo.get("whizzbang")
#var players_weapon = get_parent().warehouse_of_weapon

func _ready():
	get_node("weapon").connect("pressed", self, "_weapon")
	get_node("ammo1").connect("pressed", self, "_ammo")
	get_node("ammo2").connect("pressed", self, "_ammo")
	get_node("pod").connect("pressed", self, "weapon_for_podd")
	get_node("pod2").connect("pressed", self, "weapon_for_podd")

func weapon_for_podd():
	pass
func _weapon():
	var pos = Vector2(100, -30)
	for i in get_parent().warehouse_of_weapon:
		spawn_button(pos, i)
		pos.y += 31
	pos.y += 31
	spawn_button(pos, weapon)
	pass

func _ammo():
	pass

func spawn_button(pos, text):
	var obj = get_node("Button").duplicate()
	obj.rect_position = pos
	obj.rect_size = Vector2(130, 31)
	obj.text = text
	obj.visible = true
	obj.connect("pressed", self, "On_button_pressed")
	add_child(obj)

func On_button_pressed():
	print("here")

