extends Node2D

var SELF = self
var TIME = 3
var tipe = ""
signal END(tipe)

func _ready():
	get_node("Timer").start(TIME)


func _on_Timer_timeout():
	emit_signal("END", tipe)
	queue_free()
