extends Node2D

signal BUILD
	


func _on_Button_pressed():
	var TEXT = get_node("Button").text
	emit_signal("BUILD", TEXT)
