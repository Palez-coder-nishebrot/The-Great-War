extends Timer

var tipe_of_product
var product_or_tech
var tipe 
var part_of
var time: int = 1.0
var object:Object
func _ready():
	start(time * get_node("/root/Global").speed_of_game)
func _on_Timer_timeout():
	var object_SELF = get_node("/root/Global").countries.get(part_of)[0]
	if (tipe == null):
		if (object_SELF.warhouse_of_tech.get(product_or_tech) != null):
			object_SELF.warhouse_of_tech[product_or_tech] += 1
		else:
			object_SELF.warhouse_of_tech[product_or_tech] = 1
		queue_free()
		print(object_SELF.warhouse_of_tech)
	elif (str(tipe) == 'unit'):
		print('spawn army')
		object.spawn_unit(product_or_tech)
		queue_free()
	else:
		var warhouse
		if tipe_of_product == 'weapon':
			warhouse = object_SELF.warhouse_of_weapon
		elif tipe_of_product == 'support':
			warhouse = object_SELF.warhouse_of_support
		else: #weapon_support
			warhouse = object_SELF.warhouse_of_weapon_support
		if (warhouse.get(product_or_tech) != null):
			print(warhouse)
			warhouse[product_or_tech] += 1
		else:
			warhouse[product_or_tech] = 1
		print(warhouse)
	
