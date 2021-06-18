extends Node2D

var research_tech = { #Сталь, Пшеница,Топливо, Резина, Время
"Гарфорд Путилов": [1,1,1,1,1],
"Броненосец":   [1,1,1,1,1],}
var research_wapon = {
"Винтовка Токарева": ['weapon', 1,1,1,1,1],
"Аптечка первой помощи": ['support', 1,1,1,1,1],
"Артеллерия": ['weapon_support', 1,1,1,1,1],}
var research_units = {
"Пехотная дивизия": [1,1,1,1,1],}
###################### SERVICE ######################
var arr_of_buttons_var = []
var city_OBJECT = null
var part_of
var arr_for_buttons_to_delete = []
var arr_of_active_units = []
###################### SERVICE ######################

###################### WARHOUSES ######################
var warhouse_of_tech = {}
var warhouse_of_weapon = {}
var warhouse_of_support = {}
var warhouse_of_weapon_support = {}
###################### WARHOUSES ######################

const speed: int = 900
const speed_mouse: int = 15


var economic = {
"Вид": "Смешанная",
"Разрешение на постройку государсвтенных сооружений частным компаниям": true,
"Жетоны рабочих": 4,}

###################### PARTIES ######################
var parties = {}
###################### PARTIES ######################
func _process(delta):
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
		
	if Input.is_action_just_pressed("ESC"):
		if get_node("CanvasLayer/settings").visible == false:
			get_node("CanvasLayer/settings").visible = true
		else:
			get_node("CanvasLayer/settings").visible = false
	
	if Input.is_action_just_released("UP_mouse"):
		get_node("Camera2D").zoom.x -= speed_mouse * delta
		get_node("Camera2D").zoom.y -= speed_mouse * delta
	if Input.is_action_just_released("DOWN_mouse"):
		get_node("Camera2D").zoom.x += speed_mouse * delta
		get_node("Camera2D").zoom.y += speed_mouse * delta
	if get_node("Camera2D").zoom.x <= 0.5 and get_node("Camera2D").zoom.y <= 0.5:
		get_node("Camera2D").zoom.x = 0.5
		get_node("Camera2D").zoom.y = 0.5
	if get_node("Camera2D").zoom.x >= 2 or get_node("Camera2D").zoom.y >= 2:
		get_node("Camera2D").zoom.x = 2
		get_node("Camera2D").zoom.y = 2
func _visible(boolean, number):
	if number == 1:
		get_node("CanvasLayer/open_build0").visible = boolean
		get_node("CanvasLayer/open_build1").visible = boolean
		get_node("CanvasLayer/open_build2").visible = boolean
		get_node("CanvasLayer/open_build3").visible = boolean
	else:
		get_node("CanvasLayer/build_building").visible = boolean
		get_node("CanvasLayer/build_building2").visible = boolean
		get_node("CanvasLayer/build_building3").visible = boolean
		get_node("CanvasLayer/build_building4").visible = boolean
		get_node("CanvasLayer/build_building5").visible = boolean
		get_node("CanvasLayer/build_building6").visible = boolean
		get_node("CanvasLayer/build_building7").visible = boolean
func _ready():
	part_of = get_node("/root/Global").start_contry_for_player
	get_node("/root/Global").countries[part_of] = [get_node("/root/Global").countries[part_of][0],self]
	set_tokens_of_workers()
	get_node("/root/Global").player_self = self
	_visible(false, 1)
	_visible(false, 2)
func open(big_city_or_usually_city, buildings, object):
	for i in arr_for_buttons_to_delete:
		if i != null:
			i.queue_free()
	print('open')
	city_OBJECT = object
	_visible(false, 2)
	_visible(false, 1)
	var tk = -1
	for i in buildings:
		tk = tk + 1
		var c = str(tk)
		get_node("CanvasLayer/open_build" + c).visible = true
		get_node("CanvasLayer/open_build" + c).text = i[0]
		get_node("CanvasLayer/open_build" + c).factory_obj = i[1]
	if city_OBJECT.part_of == part_of:
		_visible(true, 2)
	else:
		_visible(false, 2)
	print(big_city_or_usually_city)
func _on_build_building_pressed(): # ФАБРИКА
	city_OBJECT.append_building(load("res://Objects/Buildings/Factory.tscn").instance())
func _on_build_building2_pressed(): # ВОЕННЫЙ ЗАВОД
	city_OBJECT.append_building(load("res://Objects/Buildings/Army_factory.tscn").instance())
func _on_build_building3_pressed(): # ФЕРМА
	city_OBJECT.append_building(load("res://Objects/Buildings/Farm.tscn").instance())
func _on_build_building6_pressed(): # КАЗАРМЫ
	city_OBJECT.append_building(load("res://Objects/Buildings/Bar-s.tscn").instance())
func set_tokens_of_workers():
	get_node("CanvasLayer/Label").text = "Жетоны рабочих:" + str(economic.get("Жетоны рабочих"))
	pass
func on_button_var_pressed(text_of_button, factory_obj):
	if text_of_button == "Военный завод":
		spawn_buttons_for_arm_factory('arm_factory', factory_obj)
	elif text_of_button == "Казармы":
		spawn_buttons_for_arm_factory('bar', factory_obj)
		pass
	elif text_of_button == "Фабрика":
		spawn_buttons_for_arm_factory('factory', factory_obj)
		pass
	else: #"Ферма"
		
		pass
func spawn_buttons_for_arm_factory(tipe, factory_obj):
	var object
	var research 
	for i in arr_of_buttons_var:
		i.queue_free()
	var pos = get_node("CanvasLayer/Products_or_unit").rect_position
	if tipe == 'factory':
		object = 'product'
		research = research_wapon
	elif tipe == 'bar':
		object = 'units'
		research = research_units
	else:
		object = 'tech'
		research = research_tech
	for i in research:
		var obj = load("res://Buttons/var_for_create_product.tscn").instance()
		print(i)
		obj.tech_or_product = object 
		obj.rect_position = pos
		obj.text = i
		obj.tile = city_OBJECT
		obj.factory_obj = factory_obj
		arr_for_buttons_to_delete.append(obj)
		get_node("CanvasLayer").add_child(obj)
		pos.y += 32


func _on_Parties_pressed():
	if get_node("CanvasLayer/Parties2").visible == false:
		get_node("CanvasLayer/Parties2").visible = true
	else:
		get_node("CanvasLayer/Parties2").visible = false
