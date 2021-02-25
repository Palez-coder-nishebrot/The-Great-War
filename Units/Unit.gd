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
var hp = 12
var attak = 12
var weapon = "Основное оружие"
var weapon_for_podd1 = "Оружие для поддержки"
var weapon_for_podd2 = "Оружие для поддержки"
var ammo1 = "Снабжение"
var ammo2 = "Снабжение"
var tech = "Техника"
var podd = "Поддержка"
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
	print(text, " ", obj) #Танк - tech/weapon_for_podd/weapon/ammo
	
