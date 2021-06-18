extends Node

var char_c = "Строится"
const tipe = "Казармы"
var finish_data
var unit 
func start() -> void:
	Global.connect('new_day_timer', self, 'check_day')
	finish_data = Global.schedule_date(5)
		
func check_day(dict) -> void:
	if finish_data['day'] == dict['day'] and finish_data['month'] == dict['month'] and finish_data['year'] == dict['year']:
		char_c = 'Готово к работе'
		get_parent().return_tk()
		print('FINISH')
		$"/root/Global".disconnect('new_day_timer', self, 'check_day')

func Mobilization(unit_):
	finish_data = Global.schedule_date(2)
	Global.connect('new_day_timer', self, 'ProcessOfMobilization')
	unit = unit_

func ProcessOfMobilization(dict):
	if finish_data['day'] == dict['day'] and finish_data['month'] == dict['month'] and finish_data['year'] == dict['year']:
		var unit_obj = load("res://Objects/units/Unit.tscn").instance()
		unit_obj.tipe_of_unit = unit
		unit_obj.tile = get_parent()
		unit_obj.position = get_parent().position
		unit_obj.part_of = get_parent().part_of
		get_parent().get_parent().add_child(unit_obj)
		PlayersObj.playersObj.get(get_parent().part_of)[1].power_points += 1
		PlayersObj.playersObj.get(get_parent().part_of)[1].arr_of_units.append(unit_obj)
