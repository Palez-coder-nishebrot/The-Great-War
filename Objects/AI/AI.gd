extends Node

####################################
####################################
var power_points: int = 0

var part_of: String 

var RulingParty: Object
var parties: Array = []

var resources: Dictionary = {
	"Металл": 100,
	"Пшеница":100,
	"Топливо":100,
	"Резина": 100,
	"Уголь":  100,
	"Нефть":  100,
}

var bonuses_for_research: int = 0

var bonuses: Dictionary = {'Кавалерия': [0, 0], #0 -> attak
'Пехотная дивизия': [0, 0],         #1 -> hp
'Наземная техника': [0, 0],}

var bonusesForAll: Dictionary = {
'Противопехотная атака':0,
'Противотанковая атака':0,
'Атака артиллерии': 0,
'Атака винтовок': 0,}

var arr_of_units: Array = []
var arr_of_tiles: Array = []
var arr_of_buildings: Dictionary = {
'Колхоз': 0,
'Казармы':0,
'Завод легкой промышленности':0,
'Завод тяжелой промышленности': 0,}
var arr_of_cities: Array = []
var arr_of_booty: Array = []

var warhouse_of_tech: Dictionary = {"Машина с пулеметом": 1, "Тяжелый танк Шевченко": 1, 'Грузовик I': 1, "Средний танк 'Галиция'": 1}

var warhouse_of_weapon: Dictionary = {"Винтовка Трехлинейка":1}

var warhouse_of_support: Dictionary = {"Аптечка первой помощи": 1}

var warhouse_of_weapon_support: Dictionary = {"Артеллерия 1910 года":1, "Гранотомет Алексеева": 1}

var research_tech: Dictionary = {} #Сталь, Пшеница,Топливо, Резина, Время

var research_wapon: Dictionary = {
"Винтовка Токарева": ['weapon', 1,1,1,1,1],
"Аптечка первой помощи": ['support', 1,1,1,1,1],
"Артеллерия 1910 года": ['weapon_support', 1,1,1,1,1],}

var research_units: Dictionary = {
"Пехотная дивизия": [1,1,1,1,1],}

var economic: Dictionary = {
"Вид": "Смешанная",
"Разрешение на постройку государственных сооружений частным компаниям": true,
"Единицы производственной мощи": 3,
'Максимум ЕПМ': 3,
'Занятые ЕПМ': 0,
'Предприятия': [],
"Деньги": 1000}

var relations_country: Dictionary = {}

func set_tipe_of_economic():
	economic["Вид"] = Ideologies.tipe_of_economic[RulingParty.Ideology]
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


func set_relations(country_object):
	var ideology = country_object.RulingParty.Ideology
	if ideology in Relations.relations_of_ideologies_friendship[RulingParty.Ideology]:
		relations_country[country_object] = 1
	else:
		relations_country[country_object] = -1
func set_Ruling_Party():
		for i in parties:
			if i.Ideology == get_node("/root/PlayersObj").political_ideology_of_countries[part_of]:
				RulingParty = i
				break
		set_tipe_of_economic()
	
func _ready():
	Global.connect("new_day_signal", self, "TimeToAct")
	
func TimeToAct():
	if arr_of_tiles.size() - arr_of_units.size() == 5:
		BuildBuildings("Казармы")
	#for i in arr_of_units:
		#if i.hp < 5:
			

		
func BuildBuildings(building):
	for i in arr_of_cities:
		if i.size() < 3:
			match building:
				"Казармы":
					i.append_building(load("res://Objects/Buildings/Bar-s.tscn"), null)
		
