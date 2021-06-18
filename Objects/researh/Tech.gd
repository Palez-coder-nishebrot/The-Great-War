extends Node2D

func _on_Button3_pressed():
	get_parent().tech_cars_rasearch(1)
func _on_Button4_pressed():
	get_parent().tech_cars_rasearch(2)
func _on_Button5_pressed():
	get_parent().tech_cars_rasearch(3)
func _on_Button6_pressed():
	get_parent().tech_cars_rasearch(4)
func _on_Button7_pressed():
	get_parent().tech_cars_rasearch(5)
func _on_Button2_pressed():
	get_node("1level_cars").visible = true
	get_node("2level_cars").visible = false
	get_node("1level_tanks").visible = false
func _on_Button8_pressed():
	get_node("1level_cars").visible = false
	get_node("2level_cars").visible = false
	get_node("1level_tanks").visible = true
func _on_cars_left_right_pressed():
	get_node("1level_cars").visible = not get_node("1level_cars").visible
	get_node("2level_cars").visible = not get_node("2level_cars").visible
func _on_tank1_pressed():
	get_parent().tech_tanks_rasearch(1)
func _on_tank2_pressed():
	get_parent().tech_tanks_rasearch(2)
func _on_tank3_pressed():
	get_parent().tech_tanks_rasearch(3)
func _on_tank4_pressed():
	get_parent().tech_tanks_rasearch(4)
func _on_tank5_pressed():
	get_parent().tech_tanks_rasearch(5)
func _on_tank6_pressed():
	get_parent().tech_tanks_rasearch(6)
