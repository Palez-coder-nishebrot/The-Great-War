extends Node2D
####################CITY VARS################################
######################################################################
var POS = null
var UNIT = null
var strike = null
var tension = 10
var what_we_make = null
var city_object = null
#########################################################################
######################################################################
const speed = 12
const speed_mouse = 15

var TILE_or_CITY_open = [null, null]

var part_of_player = null

var button_for_prod = load("res://Buttons/Button_for_production.tscn")
var timer = load("res://timer/Sleep.tscn")
var unit = load("res://Units/Unit.tscn")
var build_building = null

var warehouse_of_weapon_for_podd = {
"Артиллерия": 1
}
var warehouse_of_weapon = {
"Винтовка Токарева": 12,
}

var warehouse_of_podd = {
"Аптечка": 12,
"Саперская лопата": 10
}
var warehouse_of_ammo = {
"Патроны": 30,
"Снаряды": 50, #сняряд 
}
var warehouse_of_res = {
"Резина": 10,
"Металлы": 10,
"Пшеница": 10,
"Уголь": 10,
"Нефть": 10
}
var warehouse_of_tech = {
"Грузовик": 4,
"Зенитка": 3,
"Танк": 3
}
var research_TECH = {
"Зенитка": [5, 3, 0, 1, 2, "бронемашины"],
"Танк": [12, 3, 0, 1, 2, "танки"],
"Грузовик": [0,0,0, 1, 2, "М пехота"]
}
var research_infantry = {
"Пехота": [1, 3, 0, 1, 2]
}
###########################################################
###########################################################
#1 ВРЕМЯ, РЕСУРСЫ:, Сталь, Пшеница,Топливо, Резина
###########################################################
###########################################################
#1 Время, Металлы, Другое
var research_for_ammunition_depot = {
"Винтовка Токарева": [3, 2, 1],
"Аптечка": [3, 0, 2],
"Патроны": [3, 1, 1],
"Снаряды": [3, 2, 2], #сняряд
"Саперская лопата": [3, 1, 1],
"Артиллерия": [4, 4, 0],
}

########################################################################################
###########################################################################################
var pos_of_city = null

var ARRAY_OF_OPEN_BUTTONS = []

signal Build_building
signal Build_building_for_tile
var Name_of_city = null
var objectForBuild = null

##############################################
###############ПОЛИТИКА###########################

var party_members = []
var party = {}
var parties = {}

#####################################
####################################
func _ready():
	#parties[i] = [p[0], p[1], 10]
	zoom_camera_start_game()
	get_parent().connect("city_spawn", self, "connect_signal_to_city")
	get_parent().get_node("NEW tile").connect("new_tile", self, "connect_signal_to_tile")
	get_node("CanvasLayer/var1").visible = false
	get_node("CanvasLayer/Factory_for_other").visible = false
	get_node("CanvasLayer/ResearchMENU").visible = false
	get_node("CanvasLayer/BuildBar").visible = false
	get_node("CanvasLayer/BuildFarm").visible = false
	get_node("CanvasLayer/build_Factory").visible = false
	get_node("CanvasLayer/Oil_station").visible = false
	get_node("CanvasLayer/Mine").visible = false
	var token = 1
	for _i in range(4):
		var tokenT = str(token)
		get_node("CanvasLayer/building" + tokenT).visible = false
		token = token + 1
func connect_signal_to_city(obj):
	obj.connect('open', self, 'OPEN')#Если на объект нажали, то
func _process(delta):
	if Input.is_action_just_pressed("ESC"):
		if get_node("CanvasLayer/Exit").visible == false:
			get_node("CanvasLayer/Exit").visible = true
		else:
			get_node("CanvasLayer/Exit").visible = false
	if Input.is_action_pressed("ui_down"):
		position.y += speed
	if Input.is_action_pressed("ui_up"):
		position.y -= speed 
	if Input.is_action_pressed("ui_left"):
		position.x -= speed 
	if Input.is_action_pressed("ui_right"):
		position.x += speed
	
	if Input.is_action_just_released("UP_mouse"):
		get_node("Camera2D").zoom.x -= speed_mouse * delta
		get_node("Camera2D").zoom.y -= speed_mouse * delta
	if Input.is_action_just_released("DOWN_mouse"):
		get_node("Camera2D").zoom.x += speed_mouse * delta
		get_node("Camera2D").zoom.y += speed_mouse * delta
	if get_node("Camera2D").zoom.x <= 0.5 and get_node("Camera2D").zoom.y <= 0.5:
		get_node("Camera2D").zoom.x = 0.5
		get_node("Camera2D").zoom.y = 0.5
	if get_node("Camera2D").zoom.x >= 1 or get_node("Camera2D").zoom.y >= 1:
		get_node("Camera2D").zoom.x = 1
		get_node("Camera2D").zoom.y = 1
	
func zoom_camera_start_game():
	part_of_player = get_node("/root/Global").for_start 
	get_node("Camera2D").zoom = Vector2(0.5, 0.5)
	if part_of_player == "Gorny":
		get_node("Camera2D").position = Vector2(839, 791)
	elif part_of_player == "Adamanty":
		get_node("Camera2D").position = Vector2(407, 215)
	elif part_of_player == "Tsarstvo Bascany":
		get_node("Camera2D").position = Vector2(794, 263)
	elif part_of_player == "Nasadry":
		get_node("Camera2D").position = Vector2(262, 503)
	else:
		get_node("Camera2D").position = Vector2(1175, 551)
func OPEN(population, tipe, object, Name, build, partOf, pos, STRIKE, SELF):
	open() #обработчик невидимости кнопок
	TILE_or_CITY_open[1] = "City" #мы открыли город
	city_object = null
	strike = null
	pos_of_city = null #позиция города
	clear_button() #обработчки невидимости кнопок для производства
	build_building = null
	var token = 1
	for _i in range(3): #с помощью нехитрого цикла делаем невидимым кнопки для постройки фабрик итд
		var tokenT = str(token)
		get_node("CanvasLayer/building" + tokenT).visible = false
		token = token + 1
	get_node("CanvasLayer/population").set_text("")
	get_node("CanvasLayer/object").set_text(object)
	get_node("CanvasLayer/name").set_text(Name)
	get_node("CanvasLayer/PartOf").set_text(partOf)
	get_node("CanvasLayer/Tipe").set_text(tipe)
	if partOf == part_of_player: #если это наш город
		var populationForGR = str(population)
		get_node("CanvasLayer/population").set_text(populationForGR)
		get_node("CanvasLayer/Factory_for_other").visible = true
		get_node("CanvasLayer/BuildBar").visible = true
		get_node("CanvasLayer/BuildFarm").visible = true
		get_node("CanvasLayer/build_Factory").visible = true
		get_node("CanvasLayer/Oil_station").visible = true
		get_node("CanvasLayer/Mine").visible = true
		control(build)
		#занимаемся сохранением данных о городе в переменную 
		build_building = build
		Name_of_city = Name
		pos_of_city = pos
		strike = STRIKE
		city_object = SELF
		TILE_or_CITY_open[0] = city_object

func control(build):
	var token = 1
	for i in build:
		var tokent = str(token)
		get_node("CanvasLayer/building" + tokent).visible = true
		get_node("CanvasLayer/building" + tokent).text = i
		token = token + 1

func _on_building1_pressed():
	var Tbuilding = get_node("CanvasLayer/building1").text
	on_button_building_pressed(Tbuilding)
func _on_building2_pressed():
	var Tbuilding = get_node("CanvasLayer/building2").text
	on_button_building_pressed(Tbuilding)
func _on_building3_pressed():
	var Tbuilding = get_node("CanvasLayer/building3").text
	on_button_building_pressed(Tbuilding)
func _on_building4_pressed():
	var Tbuilding = get_node("CanvasLayer/building4").text
	on_button_building_pressed(Tbuilding)

func on_button_building_pressed(Tbuilding):
	clear_button()
	if Tbuilding == 'factory':
		var start_pos = get_node("CanvasLayer/var1").position
		var plusPos = Vector2(100, 1)
		for i in research_TECH:
			start_pos += Vector2(plusPos.x, 0)
			spawn_for_prod(start_pos, i)
	elif Tbuilding == "barak":
		var start_pos = get_node("CanvasLayer/var1").position
		var plusPos = Vector2(100, 1)
		for i in research_infantry:
			start_pos += Vector2(plusPos.x, 0)
			spawn_for_prod(start_pos, i)
	elif Tbuilding == "Factory_for_other":
		var start_pos = get_node("CanvasLayer/var1").position
		var plusPos = Vector2(100, 1)
		for i in research_for_ammunition_depot:
			start_pos += Vector2(plusPos.x, 0)
			spawn_for_prod(start_pos, i)
		pass
	else:
		print("Ферма нажата")
func clear_button():
	for i in ARRAY_OF_OPEN_BUTTONS:
		if i != null:
			i.queue_free()

func spawn_for_prod(pos, TextForButton):
	var obj = button_for_prod.instance()
	obj.connect("BUILD", self, "build_product_or_unit")
	obj.position = pos
	obj.get_node("Button").text = TextForButton
	ARRAY_OF_OPEN_BUTTONS.append(obj)
	get_node("CanvasLayer").add_child(obj)

func _on_Research_pressed():
	if get_node("CanvasLayer/ResearchMENU").visible == false:
		get_node("CanvasLayer/ResearchMENU").visible = true
	else:
		get_node("CanvasLayer/ResearchMENU").visible = false
func _on_build_Factory_pressed(): #FACTORY
	objectForBuild = "factory"
	Build()
func _on_BuildBar_pressed(): #BARAK
	objectForBuild = "barak"
	Build()
func _on_BuildFarm_pressed(): #FARM
	objectForBuild = "farm"
	Build()
func _on_Factory_for_other_pressed():
	objectForBuild = "Factory_for_other"
	Build()
func Build():
	if TILE_or_CITY_open[1] == "City":
		emit_signal("Build_building", Name_of_city, objectForBuild)
	else:
		emit_signal("Build_building_for_tile", objectForBuild, TILE_or_CITY_open[0])

func build_product_or_unit(TEXT):
	print('on button click')
	for i in research_TECH: 
		if i == TEXT: #######ПОСТРОЙКА ТЕХНИКИ##################
			POS = Vector2(pos_of_city.x - 50, pos_of_city.y)
			UNIT = i
			spawn_timer("tech")
			break
	for i in research_for_ammunition_depot: #######СОЗДАНИЕ ОРУЖИЯ И ПАТРОНОВ##################
		if i == TEXT:
			UNIT = i
			spawn_timer(i)
	for i in research_infantry:
		if i == TEXT:
			POS = Vector2(pos_of_city.x - 50, pos_of_city.y)
			UNIT = i
			spawn_timer("infantry")
			break
func _on_var1_BUILD(TEXT):
	build_product_or_unit(TEXT)
	
func spawn_timer(tipeOfUnit):
	var obj = timer.instance()
	obj.tipe = tipeOfUnit
	obj.unit = UNIT
	add_child(obj)
	
func spawn_unit():
	var obj = unit.instance()
	obj.position = POS
	obj.part_of = part_of_player
	obj.unit = UNIT
	get_parent().add_child(obj)

func _on_Oil_station_pressed():
	if TILE_or_CITY_open[0].Oil != 1:
		TILE_or_CITY_open[0].Oil += 1
		print("build oil")

func _on_Mine_pressed():
	if TILE_or_CITY_open[0].Mines != 1:
		TILE_or_CITY_open[0].Mines += 1
		print("build mine")

func connect_signal_to_tile(SELF):
	SELF.connect("open_tile", self, "open_tile_signal")

func open_tile_signal(population, _Name, build, partOf, SELF, pos):
	open()
	pos_of_city = pos
	TILE_or_CITY_open[1] = "tile"
	clear_button()
	var token = 1
	for _i in range(4):
		var tokenT = str(token)
		get_node("CanvasLayer/building" + tokenT).visible = false
		token = token + 1
	if partOf == part_of_player:
		var populationForGR = str(population)
		get_node("CanvasLayer/population").set_text(populationForGR)
		get_node("CanvasLayer/Factory_for_other").visible = true
		get_node("CanvasLayer/BuildFarm").visible = true
		get_node("CanvasLayer/build_Factory").visible = true
		get_node("CanvasLayer/Oil_station").visible = true
		get_node("CanvasLayer/Mine").visible = true
		TILE_or_CITY_open[0] = SELF
		control(build)

func open():
	get_node("CanvasLayer/BuildBar").visible = false
	get_node("CanvasLayer/BuildFarm").visible = false
	get_node("CanvasLayer/build_Factory").visible = false
	get_node("CanvasLayer/var1/Button").text = ""
	get_node("CanvasLayer/var1").visible = false
	get_node("CanvasLayer/Factory_for_other").visible = false
	get_node("CanvasLayer/Oil_station").visible = false
	get_node("CanvasLayer/Mine").visible = false

func _on_Exit_pressed():
	get_tree().quit()

