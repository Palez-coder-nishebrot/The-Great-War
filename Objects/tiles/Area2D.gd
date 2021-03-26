extends Area2D

var part_of
func _ready():
	check_part_of()

func check_part_of():
	part_of = get_parent().part_of
