extends StaticBody2D

var buildings: Array = []
var free_factories: Array = []
var level_of_railways: int = 1
var part_of: String 
var city_name: String 
var units_in_tile: Array = []
var region: String 
var vector_hex: Array = []
var neighbors: Array = []
var mine: Object
onready var sprite_object = $Sprite

func append_building(building, price) -> void:
	if price == 'free':
		building = building.instance()
		add_child(building)
		buildings.append([building.tipe, building])
		free_factories.append([building.tipe, building])
		building.start()
		get_node("/root/PlayersObj").playersObj.get(part_of)[1].arr_of_buildings[building.tipe] += 1
	elif buildings.size() < 3 and $"/root/PlayersObj".playersObj.get(part_of)[1].economic.get("Единицы производственной мощи") > 0 and $"/root/PlayersObj".playersObj.get(part_of)[1].economic.get("Деньги") >= 100:
		if building is Object:
			building = building.instance()
			add_child(building)
			buildings.append([building.tipe, building])
			free_factories.append([building.tipe, building])
			get_node("/root/PlayersObj").playersObj.get(part_of)[1].economic["Единицы производственной мощи"] -= 1
			get_node("/root/PlayersObj").playersObj.get(part_of)[1].set_tokens_of_workers()
			get_node("/root/PlayersObj").playersObj.get(part_of)[1].economic["Занятые ЕПМ"] += 1
			get_node("/root/PlayersObj").playersObj.get(part_of)[1].power_points += 1
			building.start()
			get_node("/root/PlayersObj").playersObj.get(part_of)[1].arr_of_buildings[building.tipe] += 1
			
		else:
			if level_of_railways <= 4:
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].economic["Единицы производственной мощи"] -= 1
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].set_tokens_of_workers()
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].economic["Занятые ЕПМ"] += 1
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].economic["Единицы производственной мощи"] += 1
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].economic["Деньги"] -= 100
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].economic["Занятые ЕПМ"] -= 1
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].set_tokens_of_workers()
				level_of_railways += 1
				get_node("/root/PlayersObj").playersObj.get(part_of)[1].power_points += 0.5
				return_tk()

func make_tech(tech,factory_obj) -> void:
	free_factories.erase([factory_obj.tipe, factory_obj])
	factory_obj.MakeTech(tech)
func make_product(product, _tipe_of_product,_factory_obj) -> void:
	_factory_obj.StartMakingProduct(product)
	pass
func mobilization(unit, _factory_obj) -> void:
	_factory_obj.Mobilization(unit)
func set_lebel_of_name_city(c_name):
	get_node("Node2D/Label2").set_text(c_name)
	city_name = c_name

func return_tk():
	$"/root/PlayersObj".playersObj.get(part_of)[1].economic["Единицы производственной мощи"] += 1
	$"/root/PlayersObj".playersObj.get(part_of)[1].economic["Деньги"] -= 100
	$"/root/PlayersObj".playersObj.get(part_of)[1].economic["Занятые ЕПМ"] -= 1
	$"/root/PlayersObj".playersObj.get(part_of)[1].set_tokens_of_workers()
	$"/root/PlayersObj".playersObj.get(part_of)[1].power_points += 1


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("mouse_left_button"):
		PlayersObj.PlayerObject.open('', buildings, self)
	if event.is_action_pressed("mouse_right_button"):
		for i in PlayersObj.PlayerObject.arr_of_active_units:
			i.move_arr.clear()
			i.point = position
			i.cast_to()


func set_color_focus_(bool_, part_of_):
	if bool_ == true and part_of != '':
		if part_of == part_of_:
			if TileMapReg.RegionsColorFree == []:
				TileMapReg.RegionsColorFree = TileMapReg.RegionsColorConst.duplicate(true)
			$Sprite.modulate = TileMapReg.RegionsColorFree[0]
			TileMapReg.RegionsColorFree.remove(0)
		else:
			$Sprite.modulate = TileMapReg.grey
	else:
		if part_of != '':
			$Sprite.modulate = PlayersObj.playersObj[part_of][0]
		
func _ready():
	get_node("/root/PlayersObj").PlayerObject.connect('set_color_focus', self, 'set_color_focus_')
	neighbors.append(position - Vector2(88, 160))
	neighbors.append(position - Vector2(88, -160))
	neighbors.append(position + Vector2(100, 160))
	neighbors.append(position + Vector2(100, -160))
	
	

#func StopProduction(building):
	#building.
	
	
