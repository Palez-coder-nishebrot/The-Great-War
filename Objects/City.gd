extends StaticBody2D

onready var SPEED = get_node("/root/Global")
var spawnF = load("res://Objects/City.tscn")

var population = 12
var tipe = "usually"
var object = "City"
var Name = "Tsaricen"
var partOf = "g"
var how_much_build = 0
var build = []
var control = false

var STRIKE = false

var object_for_build_but_for_city

signal open(population, tipe, object, Name, build, partOf, pos, STRIKE)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if partOf == get_parent().get_node("Player").part_of_player:
				control = true
			var pos = position
			emit_signal("open", population, tipe, object, Name, build, partOf, pos, STRIKE)

func _ready():
	if build[0] == 'none':
		build.clear()
	get_parent().get_node("Player").connect("Build_building", self, "build_building")
	
			
func build_building(Name_of_city, objectForBuild):
	if Name_of_city == Name and build.size() < 4:
		object_for_build_but_for_city = objectForBuild
		get_node("Timer").start(1 * SPEED.speed)

func _on_Timer_timeout():
	build.append(object_for_build_but_for_city)
	get_node("Timer").stop()
