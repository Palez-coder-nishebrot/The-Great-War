
extends Button

var tech_or_product
var tile 
var var_for_tipe_of_ammunition_or_support
var factory_obj
func _on_var_for_create_product_pressed():
	print(tile)
	if tech_or_product == 'tech':
		if text == "Остановить производство":
			tile.StopProduction(factory_obj)
		else:
			tile.make_tech(text,factory_obj)
	elif tech_or_product == 'units':
		tile.mobilization(text,factory_obj)
	else:
		if text == "Остановить производство":
			tile.StopProduction(factory_obj)
		else:
			tile.make_product(text, var_for_tipe_of_ammunition_or_support,factory_obj)
