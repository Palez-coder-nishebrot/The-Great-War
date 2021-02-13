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
var BODY = "UNIT"
var color
signal on_unit_click(SELF)
func _ready():
	point = position
	get_node("Sprite3").visible = false
	if part_of == "Gorny":
		get_node("Sprite").modulate #Color(1, 0.843353, 0.308594)
		print("Gorny")
	elif part_of == "Adamanty":
		print("Adamanty")
	elif part_of == "Tsarstvo Bascany":
		print("Tsarstvo Bascany")
	elif part_of == "Nasadry":
		print("Nasadry")
	else:
		print(part_of)
	get_node("Sprite2").visible = true
	set_color()
func _process(_delta):
	move_to_point()
	if control == true:
		if Input.is_action_pressed("left_mouse"):
			point = get_global_mouse_position()
			get_node("RayCast2D").look_at(point)
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
					emit_signal("on_unit_click", self)
func move_to_point():
	if position.distance_to(point) > stop_pos:
		var direction = point - position
		var norm_direction = direction.normalized()
		move_and_slide(norm_direction * speed)

func set_color():
	print(color)
	get_node("Sprite2").modulate = color
	pass
