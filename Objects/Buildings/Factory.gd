extends Node

var char_c = "Строится"
const tipe = "Завод легкой промышленности"
var finish_data
var product 
var disconnect = true

func start() -> void:
	Global.connect('new_day_timer', self, 'CheckDay')
	finish_data = Global.schedule_date(2)

func CheckDay(dict) -> void:
	if finish_data['day'] == dict['day'] and finish_data['month'] == dict['month'] and finish_data['year'] == dict['year']:
		char_c = 'Готово к работе'
		get_parent().return_tk()
		print('FINISH')
		Global.disconnect('new_day_timer', self, 'CheckDay')

func StartMakingProduct(_product):
	if disconnect == true:
		finish_data = Global.schedule_date(2)
		disconnect = false
	product = _product
	Global.connect('new_day_timer', self, 'CheckDayForMakingProduct')
	
func CheckDayForMakingProduct(dict):
	if finish_data['day'] == dict['day'] and finish_data['month'] == dict['month'] and finish_data['year'] == dict['year']:
		var object_SELF = PlayersObj.playersObj.get(get_parent().part_of)[1]
		if (product in DataBase.weapon):
			if (product in object_SELF.warhouse_of_weapon):
				object_SELF.warhouse_of_weapon[product] += 1
			else:
				object_SELF.warhouse_of_weapon[product] = 1
		elif (product in DataBase.weapon_support):
			if (product in object_SELF.warhouse_of_weapon_support):
				object_SELF.warhouse_of_weapon_support[product] += 1
			else:
				object_SELF.warhouse_of_weapon_support[product] = 1
		else:
			if (product in object_SELF.warhouse_of_support):
				object_SELF.warhouse_of_support[product] += 1
			else:
				object_SELF.warhouse_of_support[product] = 1
		finish_data = Global.schedule_date(2)
