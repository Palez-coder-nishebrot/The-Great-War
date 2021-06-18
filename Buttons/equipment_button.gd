extends Button

var object
var tipe
var object_button: Button
func _on_equipment_button_pressed():
	object.set_param(tipe, text, object_button)
