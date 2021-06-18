extends Node2D

func _ready():
	
	get_node("Artillery/Артеллерия 1914 года").status = true
	get_node("Artillery/Артеллерия 1914 года").tipe = 'artillery'
	
	get_node("Grenades/Граната").status = true
	get_node("Grenades/Граната").tipe = 'grenades'
	
	get_node("FireSupport/Окопный гранотомет").status = true
	get_node("FireSupport/Окопный гранотомет").tipe = 'FireSupport'



func _on_Art_pressed():
	get_node("Artillery").visible = true

func _on_Gran_pressed():
	get_node("Grenades").visible = true

func _on_FireSup_pressed():
	get_node("Grenades").visible = true
