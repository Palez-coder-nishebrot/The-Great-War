extends Button



func _on_equipment_variant_pressed():
	get_parent().object_button = self
	get_parent().button_pressed()
	
