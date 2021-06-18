extends KinematicBody2D

var control: bool = false
var tipe_of_unit
var point: Vector2 
var mouse_in_area: bool = false
var part_of: String = 'Адамантия'
var object_unit

var needs:Dictionary = {}
var emaciation: int = 0
###########################################################
###########################################################
var obj_for_buttons
var move_arr = []

var hp = 1
var anti_tank_attak = 0
var antipersonnel_attack = 0
###########################################################
###########################################################
var tile = null
var equipment_variant = {
	1: 'Пусто',
	2: 'Пусто',
	3: 'Пусто',
	4: 'Пусто',
	5: 'Пусто',
	6: 'Пусто',
	7: 'Пусто',
	8: 'Пусто',}
###########################################################
###########################################################
func _ready():
	obj_for_buttons = PlayersObj.PlayerObject.get_node("CanvasLayer/equipment")
	antipersonnel_attack += PlayersObj.PlayerObject.bonuses.get(tipe_of_unit)[0]
	anti_tank_attak += PlayersObj.PlayerObject.bonuses.get(tipe_of_unit)[0]
	antipersonnel_attack += PlayersObj.PlayerObject.bonusesForAll.get('Противопехотная атака')
	anti_tank_attak += PlayersObj.PlayerObject.bonusesForAll.get('Противотанковая атака')
	hp += PlayersObj.PlayerObject.bonuses.get(tipe_of_unit)[1]
	check_part_of()
	Global.connect("new_day_signal", self, "RemoveEmaciation")
func _process(_delta):
	if Input.is_action_just_pressed("mouse_left_button") and mouse_in_area == true:
		if control == false:
			control = true
			PlayersObj.PlayerObject.check_equipment(hp, anti_tank_attak, antipersonnel_attack, self)
			PlayersObj.PlayerObject.arr_of_active_units.append(self)
		else:
			control = false
			PlayersObj.PlayerObject.arr_of_active_units.erase(self)
func _on_Area2D_mouse_entered():
	mouse_in_area = true
func _on_Area2D_mouse_exited():
	mouse_in_area = false

func cast_to():
	position = tile.position
	move_arr.clear()
	var obj = load("res://Objects/point_obj/Point_obj_.tscn").instance()
	obj.position = position
	obj.point = point
	obj.parent = self
	get_parent().add_child(obj)
func check_part_of():
	get_node("pp").modulate = PlayersObj.playersObj.get(part_of)[0]
func set_param(tipe, text, object_button):
	if tipe == 'support_weapon':
		antipersonnel_attack -= get_node("/root/DataBase").weapon_support[object_button.text][0]
		anti_tank_attak -= get_node("/root/DataBase").weapon_support[object_button.text][1]
		
		object_button.text = text
		
		antipersonnel_attack += get_node("/root/DataBase").weapon_support[text][0]
		anti_tank_attak += get_node("/root/DataBase").weapon_support[text][1]
		NeedsAnalysis(text, "warhouse_of_weapon_support")
	elif tipe == 'weapon':
		antipersonnel_attack -= get_node("/root/DataBase").weapon[object_button.text] 
		
		object_button.text = text
		
		antipersonnel_attack += get_node("/root/DataBase").weapon[text] 
		NeedsAnalysis(text, "warhouse_of_weapon")
	elif tipe == 'support':
		hp -= get_node("/root/DataBase").support[object_button.text] 

		object_button.text = text
		
		hp += get_node("/root/DataBase").support[text] 
		NeedsAnalysis(text, "warhouse_of_support")
	else: #tech
		antipersonnel_attack -= get_node("/root/DataBase").tech[object_button.text][0]
		anti_tank_attak -= get_node("/root/DataBase").tech[object_button.text][1]
		hp -= get_node("/root/DataBase").tech[object_button.text][2]
		
		object_button.text = text
		
		antipersonnel_attack += get_node("/root/DataBase").tech[text][0]
		anti_tank_attak += get_node("/root/DataBase").tech[text][1]
		hp += get_node("/root/DataBase").tech[text][2]
		set_icon(text)
		NeedsAnalysis(text, "warhouse_of_tech")
	PlayersObj.PlayerObject.check_equipment(hp, anti_tank_attak, antipersonnel_attack, self)
	var name_of_button = object_button.name
	name_of_button = name_of_button[-1]
	equipment_variant[int(name_of_button)] = text
func move_to_point():
	move_arr.remove(0)
	for i in move_arr:
		if move_arr == []:
			return
		yield(get_tree().create_timer(1.0), "timeout")
		tile = i
		position = i.position

func set_icon(obj):
	var dict = get_node("/root/DataBase").tipe_of_units
	if obj in dict.get('small_tank'):
		$Sprite.texture = load("res://Graphics/Sprites/Units_on_map/Small_tank.png")
	elif obj in dict.get('medium_tank'):
		$Sprite.texture = load("res://Graphics/Sprites/Units_on_map/medium_tank.png")
	elif obj in dict.get('heavy_tank'):
		$Sprite.texture = load("res://Graphics/Sprites/Units_on_map/heavy_tank.png")
	elif obj in dict.get('cavalry'):
		$Sprite.texture = load("res://Graphics/Sprites/Units_on_map/cavalry.png")
	elif obj in dict.get('motorized_infantry'):
		$Sprite.texture = load("res://Graphics/Sprites/Units_on_map/motorized infantry.png")
	elif obj in dict.get('armored_car'):
		$Sprite.texture = load("res://Graphics/Sprites/Units_on_map/cars.png")
	else:
		$Sprite.texture = load("res://Graphics/Sprites/Units_on_map/infantry.png")

func NeedsAnalysis(object, var_):
	needs[object] = ["В наличии",var_]
	if PlayersObj.playersObj[part_of][1].get(var_)[object] > 0:
		PlayersObj.playersObj[part_of][1].get(var_)[object] -= 1
	else:
		needs[object] = ["Нет в наличии", var_]
		emaciation += 1
		hp -= 3
		anti_tank_attak -= 3
		antipersonnel_attack -= 3
func RemoveEmaciation():
	if emaciation != 0:
		for i in needs:
			if needs[i][0] == "Нет в наличии":
				if PlayersObj.playersObj[part_of][1].get(needs[i][1])[i] > 0:
					PlayersObj.playersObj[part_of][1].get(needs[i][1])[i] -= 1
					needs[i][0] = "В наличии"
					emaciation -= 1
					
				
