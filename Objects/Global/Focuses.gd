extends Node

const industrialization = {
'Индустрилизация': []
}

func Main(_text, part_of) -> void:
	var dict = get_node("/root/PlayersObj").playersObj.get(part_of)[1].arr_of_cities
	var token = 0
	for i in dict:
		if token == 2:
			break
		else:
			dict[i].level_of_railways += 1
			print(dict[i], ' railways')
		token += 1
	
func Industrialization(text, part_of) -> void:
	var dict = get_node("/root/PlayersObj").playersObj.get(part_of)[1].arr_of_cities
	for i in dict:
		if dict[i].buildings.size() < 4:
			match industrialization[text]:
				'Завод легкой промышленности':
					i.append_building(load("res://Objects/Buildings/Factory.tscn"), 'free')
				'Завод тяжелой промышленности':
					i.append_building(load("res://Objects/Buildings/Army_factory.tscn"), 'free')

