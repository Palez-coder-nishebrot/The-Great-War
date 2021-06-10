extends Node2D

var tipe: String
var text: String
var object_button: Object

func open(_text, _tipe, _object_button):
	text = _text
	tipe = _tipe
	object_button = _object_button
	visible = true

func _on_Res_pressed():
	object_button.set_tipe_children()
	get_node("/root/Focuses").call(tipe, text, get_node("/root/PlayersObj").PlayerObject.part_of)


func _on_exit_pressed():
	visible = false
