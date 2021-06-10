extends Node




func _on_City_area_entered(area):
	if area.get_parent().get_groups() == ["Tile"]:
		yield(get_tree().create_timer(0.5), "timeout")
		area.get_parent().city_name = name
		PlayersObj.playersObj[area.get_parent().part_of][1].arr_of_cities.append(area.get_parent())
		queue_free()

