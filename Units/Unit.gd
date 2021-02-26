extends KinematicBody2D

const stop_pos = 10
const speed = 50
var bombardirovshik = load("res://Sprite_Units/Bombardirovshik.png")
var bronemach = load("res://Sprite_Units/Bronemachine.png")
var istrebitel = load("res://Sprite_Units/Istrebitel.png")
var kavalerya = load("res://Sprite_Units/Kavalerya.png")
var motor_pehota = load("res://Sprite_Units/Motor_Pehota.png")
var tank = load("res://Sprite_Units/tank.png")
var part_of = null
var tipe_of_unit = null
var detailed_description_of_unit = null
var description_of_unit = null
var control = false
var unit #конкретно юнит 
var point
const BODY = "UNIT"
var pos
var stop = false
##############################################
##############################################
onready var list_weapon = get_node("/root/ListWeaponsTech")
##############################################
##############################################
var SET_attak = {
"weapon": 0,
"weapon_for_podd1":0,
"weapon_for_podd2":0,
"ammo1":0,
"ammo2":0,
"tech":0,
}
var SET_hp = {
"podd":0,
"tech":0,
}
##############################################
##############################################
var hp = 0
var attak = 0
var weapon = "weapon"
var weapon_for_podd1 = "weapon_for_podd1"
var weapon_for_podd2 = "weapon_for_podd2"
var ammo1 = "ammo1"
var ammo2 = "ammo2"
var tech = "tech"
var podd = "podd"
##############################################
##############################################
func _ready():
	point = position
	get_node("Sprite3").visible = false
	if part_of == "Gorny":
		get_node("Sprite2").modulate = Color( 0, 1, 1, 1 ) 
		print("Gorny")
	elif part_of == "Adamanty":
		get_node("Sprite2").modulate = Color( 1, 0.89, 0.77, 1 )
	elif part_of == "Tsarstvo Bascany":
		get_node("Sprite2").modulate = Color( 0.65, 0.16, 0.16, 1 )
	elif part_of == "Nasadry":
		get_node("Sprite2").modulate = Color( 1, 0.89, 0.77, 1 )
	else:
		get_node("Sprite2").modulate = Color( 1, 0.89, 0.77, 1 )
	get_node("Sprite2").visible = true
	
func _process(_delta):
	move_to_point()
	if control == true:
		if Input.is_action_just_pressed("right_mouse"):
			if stop == false:
				point = get_global_mouse_position()
				print(hp)
			check_point()
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print(detailed_description_of_unit, " ", tipe_of_unit, " ", description_of_unit)
			if part_of == get_parent().get_node("Player").part_of_player:
				if control == true:
					control = false
					get_node("Sprite3").visible = false
				else:
					control = true
					get_node("Sprite3").visible = true
					get_parent().get_node("Player").get_node("CanvasLayer").get_node("Check_unit").check_unit(self, hp, attak, weapon, weapon_for_podd1, weapon_for_podd2, ammo1, ammo2, tech, podd)

func move_to_point():
	if position.distance_to(point) > stop_pos:
		var direction = point - position
		var norm_direction = direction.normalized()
		move_and_slide(norm_direction * speed)
func check_point():
	get_node("RayCast2D").cast_to = get_global_mouse_position()
	get_node("RayCast2D").look_at(get_global_mouse_position())
	var part = get_parent().object_in_mouse_area
	if part != part_of:
		print(part, "\n", get_node("/root/Global").wars.get(part_of))
		if not part in get_node("/root/Global").wars.get(part_of):
			point = position

func abc(body):
	var part = body.partOf
	if part != part_of:
		if not part in get_node("/root/Global").wars.get(part_of):
			print("here body")
			point = position
			stop = true

func _on_Area2D2_body_entered(body):
	abc(body)

func _on_Area2D2_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	abc(body)

func _on_Area2D2_body_exited(_body):
	stop = false

func append_obj_for_inventory(text, obj, button):
	#Танк - tech/weapon_for_podd/weapon/ammo - ammo1
	print(text, obj, button)
	if obj == "tech":
		var LIST = list_weapon.tipe_of_unit.get(text)
		attak -= SET_attak["tech"]
		SET_attak['tech'] = 0
		print(LIST)
		attak += LIST[1]
		hp -= SET_hp['tech']
		SET_hp['tech'] = 0
		hp += LIST[0]
		SET_attak['tech'] += LIST[1]
		tech = text
		print("TECH")
	elif obj == "weapon_for_podd":
		if button == "weapon_podd1":
			attak -= SET_attak['weapon_for_podd1']
			SET_attak['weapon_for_podd1'] = 0
			attak += list_weapon.podd.get(text)
			SET_attak['weapon_for_podd1'] += list_weapon.podd.get(text)
			weapon_for_podd1 = text
			print("weapon_for_podd1")
		else:
			attak -= SET_attak['weapon_for_podd2']
			SET_attak['weapon_for_podd2'] = 0
			attak += list_weapon.podd.get(text)
			SET_attak['weapon_for_podd2'] += list_weapon.podd.get(text)
			weapon_for_podd2 = text
			print("weapon_for_podd2")
	elif obj == "weapon":
		attak -= SET_attak['weapon']
		SET_attak['weapon'] = 0
		attak += list_weapon.list_of_weapons.get(text)
		SET_attak['weapon'] += list_weapon.list_of_weapons.get(text)
		weapon = text
		print("weapon")
	elif obj == "podd":
		if button == "podd":
			hp -= SET_hp[podd]
			SET_hp[podd] = 0
			hp += list_weapon.medicine.get(text)
			SET_hp[podd] += list_weapon.medicine.get(text)
			weapon = text
			print("podd1")
	else: #ammo
		if button == "ammo1":
			
			ammo1 = text
			print("ammo1")
		else:
			
			ammo2 = text
			print("ammo2")
