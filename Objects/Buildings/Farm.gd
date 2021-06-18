extends Node

var char_c = "Строится"
const tipe = "Колхоз"
func start() -> void:
	$"/root/Global".connect('new_day_timer', self, 'check_day')
	finish_data = $"/root/Global".schedule_date(5)

var finish_data
		
func check_day(dict) -> void:
	if finish_data['day'] == dict['day'] and finish_data['month'] == dict['month'] and finish_data['year'] == dict['year']:
		char_c = 'Готово к работе'
		get_parent().return_tk()
		print('FINISH')
		$"/root/Global".disconnect('new_day_timer', self, 'check_day')
