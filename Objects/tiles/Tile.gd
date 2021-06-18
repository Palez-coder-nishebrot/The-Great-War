extends StaticBody2D

var mouse_entered: bool = false
var buildings = []
var arr_of_timers_for_prod = []
var part_of = null
func _process(_delta):
	if Input.is_action_just_pressed("mouse_left_button") and mouse_entered == true:
		on_tile_click()
func _on_Area2D_mouse_entered():
	mouse_entered = true
	get_node("Sprite").visible = true
func _on_Area2D_mouse_exited():
	mouse_entered = false
	get_node("Sprite").visible = false
func on_tile_click():
	get_parent().get_node("Player").open("usually_city", buildings, self)
func _ready():
	get_node("Timer").start()
func set_color():
	if part_of == "Насардия":
		get_node("Sprite2").modulate = Color( 0, 1, 1, 1 )
		get_node("Sprite").modulate = Color( 0, 1, 1, 1 )
	if part_of == "Горния":
		get_node("Sprite2").modulate = Color( 0.65, 0.16, 0.16, 1 )
		get_node("Sprite").modulate = Color( 0.65, 0.16, 0.16, 1 )
	if part_of == "Адамантия":
		get_node("Sprite2").modulate = Color( 1, 0.5, 0.31, 1 )
		get_node("Sprite").modulate = Color( 1, 0.5, 0.31, 1 )
	if part_of == "Баскакия":
		get_node("Sprite2").modulate = Color( 0, 0.5, 0.5, 1 )
		get_node("Sprite").modulate = Color( 0, 0.5, 0.5, 1 )
	if part_of == "Царство Баскакия":
		get_node("Sprite2").modulate = Color( 1, 0.39, 0.28, 1 )
		get_node("Sprite").modulate = Color( 1, 0.39, 0.28, 1 )
func _on_Timer_timeout():
	set_color()
	get_node("Area2D").check_part_of()
	get_node("Timer").queue_free()
func append_building(building):
	if buildings.size() < 4 and get_node("/root/Global").player_self.economic.get("Жетоны рабочих") > 0:
		building.number = building
		add_child(building)
		buildings.append([building.tipe, building.number])#[building.tipe] = building.number
		get_node("/root/Global").player_self.economic["Жетоны рабочих"] -= 1
		get_node("/root/Global").player_self.set_tokens_of_workers()
		building.start()
func make_tech(tech,factory_obj):
	var timer = load("res://Timers/Timer_for_make_product.tscn").instance()
	timer.product_or_tech = tech
	add_child(timer)
	arr_of_timers_for_prod.append([timer, factory_obj])
func make_product(prod, tipe_of_product,factory_obj):
	var timer = load("res://Timers/Timer_for_make_product.tscn").instance()
	timer.product_or_tech = prod
	timer.tipe = 1
	timer.tipe_of_product = tipe_of_product
	arr_of_timers_for_prod.append([timer, factory_obj])
	add_child(timer)
func mobilization(unit, factory_obj):
	var timer = load("res://Timers/Timer_for_make_product.tscn").instance()
	timer.object = self
	timer.product_or_tech = unit
	timer.tipe = 'unit'
	add_child(timer)
	arr_of_timers_for_prod.append([timer, factory_obj])
	print(unit, 'bruh')

func spawn_unit(tipe):
	var obj = load("res://Objects/units/Unit.tscn").instance()
	obj.position = Vector2(position.x - 50, position.y - 50)
	obj.part_of = part_of
	get_parent().add_child(obj)

