extends Node2D

signal set_color_focus(tipe, partOf)
 #Сталь, Пшеница,Топливо, Резина, Время, Уголь

var resources: Dictionary = {
	"Металл": 100,
	"Пшеница":100,
	"Топливо":100,
	"Резина": 100,
	"Уголь":  100,
	"Нефть":  100,
}
var research_tech: Dictionary = {
	"Машина с пулеметом": [1,1,1,1,1],
	"Первый Броневик Путилова": [1,1,1,1,1]}
var research_wapon: Dictionary = {
	"Винтовка Токарева": ['weapon', 1,1,1,1,1],
	"Аптечка первой помощи": ['support', 1,1,1,1,1],
	"Артеллерия 1910 года": ['weapon_support', 1,1,1,1,1],}

var research_units: Dictionary = {
	"Пехотная дивизия": [1,1,1,1,1],
	}
###################### SERVICE ######################
###################### SERVICE ######################
var arr_of_buttons_var: Array = []
var city_OBJECT: Object = null
var part_of: String
var arr_for_buttons_to_delete: Array = []

var party_ready_to_take_over

var set_color_focus: bool = false

var arr_of_units: Array = []
var arr_of_active_units: Array = []
var arr_of_tiles: Array = []
var arr_of_buildings: Dictionary = {
	'Колхоз': 0,
	'Казармы':0,
	'Завод легкой промышленности':0,
	'Завод тяжелой промышленности': 0,}
var arr_of_cities: Array = []
var arr_of_booty: Array = []

var power_points: int = 0
var parties: Array = []
var RulingParty: Object
var Solutions: Dictionary = {
	"Социальные гарантии": 'Economic'
	}
###################### SERVICE ######################
###################### SERVICE ######################

###################### WARHOUSES ######################
###################### WARHOUSES ######################
var warhouse_of_tech: Dictionary = {
	"Машина с пулеметом": 1, 
	"Тяжелый танк Шевченко": 1, 
	'Грузовик I': 1, 
	"Средний танк 'Галиция'": 1}
var warhouse_of_weapon: Dictionary = {
	"Винтовка Трехлинейка":1}
var warhouse_of_support: Dictionary = {
	"Аптечка первой помощи": 1}
var warhouse_of_weapon_support: Dictionary = {
	"Артеллерия 1910 года":1, 
	"Гранотомет Алексеева": 1}
###################### WARHOUSES ######################
###################### WARHOUSES ######################
################################################################
################################################################
var bonuses_for_research: int = 0
var bonusesForAll: Dictionary = {
	'Противопехотная атака':0,
	'Противотанковая атака':0,
	'Атака артиллерии': 0,
	'Атака винтовок': 0,
}
var bonuses: Dictionary = {
	'Кавалерия': [0, 0], #0 -> attak
	'Пехотная дивизия': [0, 0],         #1 -> hp
	'Наземная техника': [0, 0],}
################################################################
################################################################
const speed: int = 900
const speed_mouse: float = 10.0
################################################################
################################################################
var economic: Dictionary = {
	"Вид": "Смешанная",
	"Разрешение на постройку государственных сооружений частным компаниям": true,
	"Единицы производственной мощи": 3,
	'Максимум ЕПМ': 3,
	'Занятые ЕПМ': 0,
	'Предприятия': [],
	"Деньги": 1000}
################################################################
################################################################
func _process(delta) -> void:
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	
	if Input.is_action_just_released("UP_mouse"):
		get_node("Camera2D").zoom.x -= speed_mouse * delta
		get_node("Camera2D").zoom.y -= speed_mouse * delta
		if get_node("Camera2D").zoom.x <= 1:
			set_color_focus = true
			emit_signal("set_color_focus", set_color_focus, part_of)
		else:
			emit_signal("set_color_focus", set_color_focus, part_of)
			
	if Input.is_action_just_released("DOWN_mouse"):
		get_node("Camera2D").zoom.x += speed_mouse * delta
		get_node("Camera2D").zoom.y += speed_mouse * delta
		if get_node("Camera2D").zoom.x >= 1:
			set_color_focus = false
			emit_signal("set_color_focus", set_color_focus, part_of)
		else:
			emit_signal("set_color_focus", set_color_focus, part_of)
			
	if get_node("Camera2D").zoom.x <= 0.5 and get_node("Camera2D").zoom.y <= 0.5:
		get_node("Camera2D").zoom.x = 0.5
		get_node("Camera2D").zoom.y = 0.5
	if get_node("Camera2D").zoom.x >= 2 or get_node("Camera2D").zoom.y >= 2:
		get_node("Camera2D").zoom.x = 2
		get_node("Camera2D").zoom.y = 2
func _visible(boolean, number) -> void:
	if number == 1:
		get_node("CanvasLayer/open_build0").visible = boolean
		get_node("CanvasLayer/open_build1").visible = boolean
		get_node("CanvasLayer/open_build2").visible = boolean
		get_node("CanvasLayer/open_build3").visible = boolean
	else:
		get_node("CanvasLayer/build_building").visible = boolean
		get_node("CanvasLayer/build_building2").visible = boolean
		get_node("CanvasLayer/build_building3").visible = boolean
		get_node("CanvasLayer/build_building8").visible = boolean
		get_node("CanvasLayer/build_building6").visible = boolean
func _ready() -> void:
	part_of = get_node("/root/PlayersObj").start_country_for_player
	get_node("/root/PlayersObj").playersObj[part_of].append(self)
	get_node("/root/PlayersObj").PlayerObject = self
	get_node("/root/Global").connect("new_day", self, 'update_time')
	for i in get_node("/root/DataBase").CompanyName:
		var obj = load("res://Objects/Companies/Company.tscn").instance()
		obj.name_ = i
		obj.part_of = part_of
		economic['Предприятия'].append(obj)
	set_tokens_of_workers()
	_visible(false, 1)
	_visible(false, 2)
func open(_big_city_or_usually_city, buildings, object) -> void:
	for i in arr_for_buttons_to_delete:
		if i != null:
			i.queue_free()
		arr_for_buttons_to_delete = []
	city_OBJECT = object
	_visible(false, 2)
	_visible(false, 1)
	var tk = -1
	for i in buildings:
		tk = tk + 1
		if i[1].char_c == 'Готово к работе':
			get_node("CanvasLayer/open_build" + str(tk)).visible = true
			get_node("CanvasLayer/open_build" + str(tk)).text = i[0]
			get_node("CanvasLayer/open_build" + str(tk)).factory_obj = i[1]
	if city_OBJECT.part_of == part_of:
		_visible(true, 2)
	else:
		_visible(false, 2)
func _on_build_building_pressed() -> void:# ФАБРИКА
	city_OBJECT.append_building(load("res://Objects/Buildings/Factory.tscn"), null)
func _on_build_building2_pressed() -> void: # ВОЕННЫЙ ЗАВОД
	city_OBJECT.append_building(load("res://Objects/Buildings/Army_factory.tscn"), null)
func _on_build_building3_pressed() -> void: # ФЕРМА
	city_OBJECT.append_building(load("res://Objects/Buildings/Farm.tscn"), null)
func _on_build_building6_pressed() -> void: # КАЗАРМЫ
	city_OBJECT.append_building(load("res://Objects/Buildings/Bar-s.tscn"), null)
func _on_build_building8_pressed() -> void:
	city_OBJECT.append_building('railways', null)
func set_tokens_of_workers() -> void:
	get_node("CanvasLayer/Label").text = "Единицы производственной мощи: " + str(economic.get("Единицы производственной мощи"))
	get_node("CanvasLayer/Label2").text = "Казна: " + str(economic.get("Деньги"))
func on_button_var_pressed(text_of_button, factory_obj) -> void:
	if text_of_button == "Завод тяжелой промышленности":
		spawn_buttons_for_arm_factory('arm_factory', factory_obj)
	elif text_of_button == "Казармы":
		spawn_buttons_for_arm_factory('bar', factory_obj)
		pass
	elif text_of_button == "Завод легкой промышленности":
		spawn_buttons_for_arm_factory('factory', factory_obj)
		pass
	else: #"Ферма"
		
		pass
func spawn_buttons_for_arm_factory(tipe, factory_obj) -> void:
	var object
	var research 
	for i in arr_of_buttons_var:
		i.queue_free()
	var pos = get_node("CanvasLayer/Products_or_unit").rect_position
	get_node("CanvasLayer/Products_or_unit").visible = true
	match tipe:
		'factory':
			research = research_wapon
		'bar':
			object = 'units'
			research = research_units
		'arm_factory':
			object = 'tech'
			research = research_tech
	for i in research:
		pos.y += 32
		var obj = load("res://Buttons/var_for_create_product.tscn").instance()
		obj.tech_or_product = object 
		obj.rect_position = pos
		obj.text = i
		obj.tile = city_OBJECT
		obj.factory_obj = factory_obj
		arr_for_buttons_to_delete.append(obj)
		get_node("CanvasLayer").add_child(obj)
		pos.y += 32
	
func _on_Parties_pressed() -> void:
	get_node("CanvasLayer/Parties2").visible = not get_node("CanvasLayer/Parties2").visible 

func check_equipment(hp, anti_tank_attak,antipersonnel_attack, object_unit) -> void:
	var object = get_node("CanvasLayer/equipment")
	get_node("CanvasLayer/equipment").object_unit = object_unit
	object.get_node("antipersonnel_attack").text = 'Противопехотная атака: ' + str(antipersonnel_attack)
	object.get_node("anti_tank_attak").text = 'Противотанковая атака: ' + str(anti_tank_attak)
	object.get_node("hp").text = 'Защита: ' + str(hp)
	object.visible = true

func _on_research_pressed() -> void:
	get_node("CanvasLayer/Research").visible = not get_node("CanvasLayer/Research").visible

func update_time(time) -> void:
	CheckPoliticalEnvironment()
	get_node("CanvasLayer/time").set_text(time)
func _on_Country_infoButton_pressed():
	get_node("CanvasLayer/Country_info").visible = not get_node("CanvasLayer/Country_info").visible

func set_tipe_of_economic() -> void:
	economic["Вид"] = get_node("/root/DataBase").tipe_of_economic[RulingParty.Ideology]
	var num 
	match economic["Вид"]:
		"Смешанная": 
			num = 3
		"Плановая":
			num = 4
		"Рыночная":
			num = 2
	var minus = economic["Максимум ЕПМ"] - economic['Занятые ЕПМ']
	var plus = num - minus
	economic["Максимум ЕПМ"] = num
	economic["Единицы производственной мощи"] += plus
		
	print(economic["Максимум ЕПМ"])
	print(economic["Занятые ЕПМ"])
	print(economic["Единицы производственной мощи"])
	print(economic["Вид"])
	print('player')

func ChangeRulingParty():
	RulingParty = party_ready_to_take_over
	PlayersObj.political_ideology_of_countries[part_of] = RulingParty.Ideology
	set_tipe_of_economic()
func set_Ruling_Party() -> void:
	for i in parties:
		if i.Ideology == PlayersObj.political_ideology_of_countries[part_of]:
			RulingParty = i
			RulingParty.Popularity = 64
		else:
			i.Popularity = 6
	get_node("CanvasLayer/Parties2").check_party()

func set_relations(_b) -> void:
	pass


func _on_Nation_FocusesButton_pressed():
	$"CanvasLayer/Nation Focuses ArmyButton".visible = not $"CanvasLayer/Nation Focuses ArmyButton".visible
	$"CanvasLayer/Nation Focuses EconomicButton".visible = not $"CanvasLayer/Nation Focuses EconomicButton".visible
	$"CanvasLayer/Nation Focuses PoliticButton".visible = not $"CanvasLayer/Nation Focuses PoliticButton".visible
func _on_Nation_Focuses_EconomicButton_pressed():
	get_node("CanvasLayer/National Focuses Economic").visible = not get_node("CanvasLayer/National Focuses Economic").visible

func CheckPoliticalEnvironment():
	for i in parties:
		if i != RulingParty:
			if i.Popularity >= 50:
				Solutions["Новый претендент на власть"] = "Domestic policy"
				party_ready_to_take_over = i
