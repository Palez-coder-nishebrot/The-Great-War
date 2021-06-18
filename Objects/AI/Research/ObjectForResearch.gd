extends Node

var text: String = name
var tipe
var parent

func _Research():
	set_tipe_children()
	var object = load("res://Objects/researh/ProcessOfResearch.tscn").instance()
	add_child(object)
	object.call(tipe, $Label.text, PlayersObj.PlayerObject.part_of, self)

func set_tipe_children():
	for i in get_children():
		i.tipe = tipe
		i.parent = parent
		
		
