extends StaticBody2D

var BODY = "TILE"
var tipe_of_tile = null
var passability = 0
var partOf = "None"
var control = false
var what_we_build = null
var build_now = false
var build = []
var population = 10
var Oil = 0
var Mines = 0
var Railway = 0
var Name = name
signal open_tile(population, Name, build, partOf, SELF, pos)

onready var Colours_for_count = get_node("/root/Global").country 
func _check():
	if partOf != "None" and partOf != null:
		var tk = Colours_for_count.get(partOf)
		$Sprite2.modulate = tk
	
func _ready():
	get_parent().get_parent().get_node("Player").connect('Build_building_for_tile', self, "build")
	if tipe_of_tile == "forest":
		passability += 7
	else:
		passability += 40
	get_parent().get_parent().connect("timeout", self, "_check")

func _on_Area2D_body_entered(body):
	if body.BODY == "UNIT" and body.part_of != partOf:
		partOf = body.part_of
		var tk = Colours_for_count.get(partOf)
		$Sprite2.modulate = tk
func _on_Area2D_body_exited(_body):
	pass


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if partOf == get_parent().get_parent().get_node("Player").part_of_player:
				control = false
			emit_signal("open_tile", population, Name, build, partOf, self, position)
	
func build(objectForBuild, TILE_or_CITY_open):
	if TILE_or_CITY_open == self and build_now == false:
		var tk = 0
		for i in build:
			tk += 1
		if tk < 2:
			print("BUILD EEEEEEEEE")
			get_node("Timer").start(1)
			what_we_build = objectForBuild
			

func _on_Timer_timeout():
	get_node("Timer").stop()
	build.append(what_we_build)
	build_graphics(what_we_build, build)
	build_now = false
	get_parent().get_node("Player").economic["Жетоны рабочих"] += 1
	
func build_graphics(build_, build_array):
	var size = build_array.size()
	if build_ == "factory":
		spawn_picture(load("res://Sprites/2020_08_05_080506.png"), size)
	elif build_ == "farm":
		spawn_picture(load("res://Sprites/ferma.png"), size)
	else:
		spawn_picture(load("res://Sprites/fabric2.png"), size)
		
func spawn_picture(build_, size):
	var obj = load("res://Objects/SPRT.tscn").instance()
	if size == 1:
		obj.position = Vector2(-3, -1)
	else:
		obj.position = Vector2(1, 1)
	obj.scale = Vector2(0.05, 0.05)
	obj.texture = build_
	add_child(obj)

