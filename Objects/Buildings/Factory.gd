extends Node

var char_c = "Строится"
const tipe = "Фабрика"
var timer_var = null
var number = null
func start():
	build_factory()

func build_factory():
	var obj = Timer.new()
	obj.connect("timeout", self, '_on_Timer_timeout')
	obj.autostart = true
	obj.one_shot = true
	add_child(obj)
	timer_var = obj

func _on_Timer_timeout():
	char_c = 'Готово к работе'
	get_node("/root/Global").player_self.economic["Жетоны рабочих"] = get_node("/root/Global").player_self.economic["Жетоны рабочих"] + 1
	get_node("/root/Global").player_self.set_tokens_of_workers()
	timer_var.queue_free()
