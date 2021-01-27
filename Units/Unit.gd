extends KinematicBody2D

const stop_pos = 10
const speed = 50
var bombardirovshik = load("res://Sprite_Units/Bombardirovshik.png")
var bronemach = load("res://Sprite_Units/Bronemachine.png")
var istrebitel = load("res://Sprite_Units/Istrebitel.png")
var kavalerya = load("res://Sprite_Units/Kavalerya.png")
var motor_pehota = load("res://Sprite_Units/Motor_Pehota.png")
var tank = load("res://Sprite_Units/tank.png")
onready var tiles = load("res://Tilemap.tres")
var part_of = null
var tipe_of_unit = null
var detailed_description_of_unit = null
var description_of_unit = null
var control = false
var unit
var point
var check_tile = null
var name_of_tile
func _ready():
	point = position
	get_node("Sprite2").visible = false
	if part_of == "Sausenya":
		get_node("Light2D").color.r = 0
	elif part_of == "Rawnina":
		get_node("Light2D").color.r = 60
		get_node("Light2D").color.g = 60
		get_node("Light2D").color.b = 60
	elif part_of == "Korolewstvo Istland":
		get_node("Light2D").color.g = 0
		get_node("Light2D").color.a = 0
		get_node("Light2D").color.r = 0
	elif part_of == "Beregowot Korolestwo":
		get_node("Light2D").color.g = 167
		get_node("Light2D").color.b = 0
	else:
		get_node("Light2D").color.g = 0
		get_node("Light2D").color.b = 0
	if tipe_of_unit == "tech":
		if description_of_unit == "bronemach":
			
			pass
		elif description_of_unit == "tank":
			pass
		else: #самолеты
				pass
	else: #infantry
		
		pass

func _process(_delta):
	check_tile = get_node("RayCast2D/Node2D").position
	move_to_point()
	chek_tile(check_tile)
	if control == true:
		get_node("Sprite2").visible = true
		if Input.is_action_pressed("left_mouse"):
			point = get_global_mouse_position()
			get_node("RayCast2D").look_at(point)
	else:
		get_node("Sprite2").visible = false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if control == true:
				control = false
			else:
				control = true
func move_to_point():
	if position.distance_to(point) > stop_pos:
		var direction = point - position
		var norm_direction = direction.normalized()
		move_and_slide(norm_direction * speed)
		
func chek_tile(where):
	#get_parent().get_node("TileMap").value = check_tile
	#get_parent().get_node("TileMap").CHECK = true
	#name_of_tile = get_parent().get_node("TileMap").name_of_tile
	#print(name_of_tile)
	#if name_of_tile == 3:
		#print("check")
	pass
