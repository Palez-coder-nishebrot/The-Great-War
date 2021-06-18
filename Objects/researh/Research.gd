extends Node2D

var cavalryLevel = 0
var weaponPolAvtLevel = 0
var weaponAvtLevel = 0
var techCarsLevel = 0
var techTanksLevel = 0
var supportHelmetsLevel = 0
var supportArtilleryLevel = 0
var FireSupportLevel = 0

func _on_Kavalry_pressed():
	control_visible(get_node("KavalryPart"))
func _on_Weapon_pressed():
	control_visible(get_node("WeaponPart"))
func _on_h_pressed():
	control_visible(get_node("Tech"))
func _on_FireSupportButton_pressed():
	control_visible(get_node("Support"))
func control_visible(object):
	var arr = [get_node("Tech"), 
	get_node("WeaponPart"),
	get_node("Support"),
	get_node("KavalryPart")]
	for i in arr:
		i.visible = false
	object.visible = true

