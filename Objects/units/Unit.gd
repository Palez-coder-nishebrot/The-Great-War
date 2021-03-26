extends KinematicBody2D

var stop: bool = true
var control = false
var tipe_of_unit
var point: Vector2 = position
var speed: int = 50
var mouse_in_area: bool = false
var part_of = 'Адамантия'
const stop_pos: int = 10
func _ready():
	point = position
	check_part_of()
func _process(delta):
	move_to_point()
	if Input.is_action_just_pressed("mouse_right_button") and control == true:
		point = get_global_mouse_position()
		get_node("Area").look_at(point)
	if Input.is_action_just_pressed("mouse_left_button") and mouse_in_area == true:
		if control == false:
			control = true
		else:
			control = false
func move_to_point():
	if position.distance_to(point) > stop_pos and stop == true:
		var direction = point - position
		var norm_direction = direction.normalized()
		move_and_slide(norm_direction * speed)
func _on_Area2D_mouse_entered():
	mouse_in_area = true
func _on_Area2D_mouse_exited():
	mouse_in_area = false
func _on_Area_area_entered(area):
	if area.get_groups() == ['tile_area_']:
		if area.part_of == part_of:
			stop = true
		else:
			stop = false
func check_part_of():
	get_node("pp").modulate = get_node("/root/Global").countries.get(part_of)[0]

