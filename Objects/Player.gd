extends Node2D
####################CITY VARS################################
######################################################################
var POS = null
var UNIT = null
var OBJ = null
var strike = null
var tension = 10
var what_we_make = null
#########################################################################
######################################################################
const speed = 12
const speed_mouse = 15

#var make_units_tech_Question = false
#var make_units_Question = false
#var make_products = false
#var train_infantry = false

var part_of_player = "Sausenya"

var button_for_prod = load("res://Buttons/Button_for_production.tscn")
var timer = load("res://timer/Sleep.tscn")
var unit = load("res://Units/Unit.tscn")
var build_building = null

var warehouse_of_weapon = {
"Nivel's gun": 12,
"first aid kit": 12,
"ammo_for_gun": 30,
"whizzbang": 50, #сняряд
"trench knife": 10
}

var warehouse_of_res = {
"Резина": 10,
"Металлы": 10,
"Еда": 10,
"Топливо": 10,
"Снаряжение": 10,
"Снаряды": 0,
}

var research_TECH = {
"anti_air_track": [5, 3, 0, 1, 2, "бронемашины"],
"tank": [12, 3, 0, 1, 2, "танки"],
}
var research_infantry = {
"infantry": [1, 3, 0, 1, 2]
}
###########################################################
###########################################################
#1 ВРЕМЯ, РЕСУРСЫ:, Металлы, Еда,Топливо, Резина
###########################################################
###########################################################
var research_for_ammunition_depot = {
"Nivel's gun": [3, 2, 1],
"first aid kit": [3, 0, 2],
"ammo_for_gun": [3, 1, 1],
"whizzbang": [3, 2, 2], #сняряд
"trench knife": [3, 1, 1]
}

########################################################################################
###########################################################################################
#1 Время, Металлы, Другое
var pos_of_city = null

var ARRAY_OF_OPEN_BUTTONS = []

signal Build_building
var Name_of_city = null
var objectForBuild = null

func _ready():
	get_parent().connect("city_spawn", self, "connect_signal_to_city")
	get_node("CanvasLayer/var1").visible = false
	get_node("CanvasLayer/Factory_for_other").visible = false
	get_node("CanvasLayer/ResearchMENU").visible = false
	get_node("CanvasLayer/BuildBar").visible = false
	get_node("CanvasLayer/BuildFarm").visible = false
	get_node("CanvasLayer/build_Factory").visible = false
	var token = 1
	for _i in range(4):
		var tokenT = str(token)
		get_node("CanvasLayer/building" + tokenT).visible = false
		token = token + 1
func connect_signal_to_city(obj):
	obj.connect('open', self, 'OPEN')#Если на объект нажали, то
func _physics_process(delta):
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
	

func OPEN(population, tipe, object, Name, build, partOf, pos, STRIKE):
	strike = null
	pos_of_city = null
	clear_button()
	build_building = null
	get_node("CanvasLayer/BuildBar").visible = false
	get_node("CanvasLayer/BuildFarm").visible = false
	get_node("CanvasLayer/build_Factory").visible = false
	get_node("CanvasLayer/var1/Button").text = ""
	get_node("CanvasLayer/var1").visible = false
	get_node("CanvasLayer/Factory_for_other").visible = false
	var token = 1
	for _i in range(3):
		var tokenT = str(token)
		get_node("CanvasLayer/building" + tokenT).visible = false
		token = token + 1
	get_node("CanvasLayer/population").set_text("")
	get_node("CanvasLayer/object").set_text(object)
	get_node("CanvasLayer/name").set_text(Name)
	get_node("CanvasLayer/PartOf").set_text(partOf)
	get_node("CanvasLayer/Tipe").set_text(tipe)
	if partOf == part_of_player:
		var populationForGR = str(population)
		get_node("CanvasLayer/population").set_text(populationForGR)
		get_node("CanvasLayer/Factory_for_other").visible = true
		get_node("CanvasLayer/BuildBar").visible = true
		get_node("CanvasLayer/BuildFarm").visible = true
		get_node("CanvasLayer/build_Factory").visible = true
		control(build)
		build_building = build
		Name_of_city = Name
		pos_of_city = pos
		strike = STRIKE

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
	if strike != true:
		if Tbuilding == 'factory':
			print('openFact')
			var token = get_node("CanvasLayer/var1").position
			var IforR = -1
			var set_text_for_first_button = "NONE"
			for i in research_TECH:
				if research_TECH.size() == IforR + 2:
					set_text_for_first_button = i
					break
				else:
					print(i)
					spawn_for_prod(Vector2(token), i)
					token.x += 108
					token.y += 1
				IforR = IforR + 1
			get_node("CanvasLayer/var1").visible = true
			get_node("CanvasLayer/var1/Button").text = set_text_for_first_button
		elif Tbuilding == "farm":
			if tension <= 20:
				print("Люди немного обеспокоины")
			elif tension <= 40:
				print("Люди беспокоятся")
			elif tension <= 70:
				print("Массовые волнения")
			else:
				print("Забастовка крестьян")
				
		elif Tbuilding == "barak":
			var token = get_node("CanvasLayer/var1").position
			var IforR = -1
			var set_text_for_first_button = "NONE"
			for i in research_infantry:
				if research_infantry.size() == IforR + 2:
					set_text_for_first_button = i
					break
				else:
					print(i)
					spawn_for_prod(Vector2(token), i)
					token.x += 108
					token.y += 1
				IforR = IforR + 1
			get_node("CanvasLayer/var1").visible = true
			get_node("CanvasLayer/var1/Button").text = set_text_for_first_button
			pass
			
		else:
			print("фабрика нажата")
			var token = get_node("CanvasLayer/var1").position
			var IforR = -1
			var set_text_for_first_button = "NONE"
			for i in research_for_ammunition_depot:
				if research_for_ammunition_depot.size() == IforR + 2:
					set_text_for_first_button = i
					break
				else:
					print(i)
					spawn_for_prod(Vector2(token), i)
					token.x += 108
					token.y += 1
				IforR = IforR + 1
			get_node("CanvasLayer/var1").visible = true
			get_node("CanvasLayer/var1/Button").text = set_text_for_first_button
			
	else:
		print("Массовая забаствока, а где-то и вооруженное восстание")
func clear_button():
	for i in ARRAY_OF_OPEN_BUTTONS:
		if i != null:
			i.queue_free()
	pass
func spawn_for_prod(pos, TextForButton):
	pos.x += 108
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
	emit_signal("Build_building", Name_of_city, objectForBuild)

func build_product_or_unit(TEXT):
	print('on button click')
	for i in research_TECH: 
		if i == TEXT: #######ПОСТРОЙКА ТЕХНИКИ##################
			POS = Vector2(pos_of_city.x - 50, pos_of_city.y)
			UNIT = i
			OBJ = i
			spawn_timer("Tech")
			break
	for i in research_for_ammunition_depot: #######СОЗДАНИЕ ОРУЖИЯ И ПАТРОНОВ##################
		if i == TEXT:
			OBJ = i
			UNIT = i
			warehouse_of_weapon[i] += 1
			break
	for i in research_infantry:
		if i == TEXT:
			POS = Vector2(pos_of_city.x - 50, pos_of_city.y)
			OBJ = i
			UNIT = i
			spawn_timer("infantry")
			break
func _on_var1_BUILD(TEXT):
	build_product_or_unit(TEXT)
	
func spawn_timer(tipeOfUnit):
	var obj = timer.instance()
	obj.tipe = tipeOfUnit
	add_child(obj)
	obj.connect("END", self, "spawn_unit")
	
func spawn_unit(tipe):
	var obj = unit.instance()
	obj.position = POS
	obj.part_of = part_of_player
	obj.tipe_of_unit = tipe
	obj.unit = UNIT
	get_parent().add_child(obj)
