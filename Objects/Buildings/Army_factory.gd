extends Node

var char_c = "Строится"
const tipe = "Завод тяжелой промышленности"
var finish_data
var product
var disconnect = true
func start() -> void:
	Global.connect('new_day_timer', self, 'check_day')
	finish_data = Global.schedule_date(5)
		
func check_day(dict) -> void:
	if finish_data['day'] == dict['day'] and finish_data['month'] == dict['month'] and finish_data['year'] == dict['year']:
		char_c = 'Готово к работе'
		get_parent().return_tk()
		Global.disconnect('new_day_timer', self, 'check_day')

func MakeTech(tech):
	if disconnect == true:
		Global.connect('new_day_timer', self, 'CheckData')
		
	product = tech
	finish_data = Global.schedule_date(2)
func CheckData(dict):
	if PlayersObj.PlayerObject.resources["Уголь"] != 0:
		PlayersObj.PlayerObject.resources["Уголь"] -= 1
		if finish_data['day'] == dict['day'] and finish_data['month'] == dict['month'] and finish_data['year'] == dict['year']:
			if product in PlayersObj.playersObj.get(get_parent().part_of)[1].warhouse_of_tech:
				PlayersObj.playersObj.get(get_parent().part_of)[1].warhouse_of_tech[product] += 1
			else:
				PlayersObj.playersObj.get(get_parent().part_of)[1].warhouse_of_tech[product] = 1
		else:
			finish_data = Global.schedule_date(2)
			print(product, ' делается...')
	else:
		disconnect('new_day_timer', self, 'check_day')
		
	
