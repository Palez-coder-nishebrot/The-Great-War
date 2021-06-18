extends Button 
var factory_obj
func _on_Button_pressed():
	get_parent().get_parent().on_button_var_pressed(text,factory_obj) 
	
