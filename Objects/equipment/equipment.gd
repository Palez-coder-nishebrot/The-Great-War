extends Node2D

var arr_of_button: Array = []
var object_unit:   Object
var object_button: Button
func _on_support_pressed():
	spawn_button(get_parent().get_parent().warhouse_of_support, 'support', object_button)
func _on_support_weapon_pressed():
	spawn_button(get_parent().get_parent().warhouse_of_weapon_support, 'support_weapon', object_button)
func _on_weapon_pressed():
	spawn_button(get_parent().get_parent().warhouse_of_weapon, 'weapon', object_button)
func _on_tech_pressed():
	spawn_button(get_parent().get_parent().warhouse_of_tech, 'tech', object_button )
func spawn_button(dictionary, tipe, _obj_button) -> void:
	var pos = get_node("equipment_button").rect_position
	var pos_plus = 30
	for i in arr_of_button:
		i.queue_free()
	arr_of_button.clear()
	for i in dictionary:
		var obj = load("res://Buttons/equipment_button.tscn").instance()
		pos.y = pos.y + pos_plus
		obj.rect_position = pos
		obj.text = i
		obj.visible = true
		obj.tipe = tipe
		obj.object = object_unit
		obj.object_button = object_button
		arr_of_button.append(obj)
		add_child(obj)

func button_pressed():
	$button_variant_support.visible = true
	$button_variant_support_weapon.visible = true
	$button_variant_tech.visible = true
	$button_variant_weapon.visible = true
	for i in arr_of_button:
		i.queue_free()
	arr_of_button.clear()
	
func _on_support2_pressed():
	spawn_button(get_parent().get_parent().warhouse_of_support, 'support2', object_button)


func _on_exit_pressed():
	visible = false


func _on_equipment_visibility_changed():
	print(object_unit)
	print(object_unit.equipment_variant)
	$equipment_variant1.text = object_unit.equipment_variant[1]
	$equipment_variant2.text = object_unit.equipment_variant[2]
	$equipment_variant3.text = object_unit.equipment_variant[3]
	$equipment_variant4.text = object_unit.equipment_variant[4]
	$equipment_variant5.text = object_unit.equipment_variant[5]
	$equipment_variant6.text = object_unit.equipment_variant[6]
	$equipment_variant7.text = object_unit.equipment_variant[7]
	$equipment_variant8.text = object_unit.equipment_variant[8]

