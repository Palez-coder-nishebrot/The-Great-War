extends Node


func _on_City_area_entered(area):
	if area.get_parent().get_groups() == ["Tile"]:
		var timer = Timer.new()
		add_child(timer)
		timer.start(5.0)
		yield(timer, "timeout")
		area.get_parent().city_name = name
		PlayersObj.playersObj[area.get_parent().part_of][1].arr_of_cities.append(area.get_parent())
		queue_free()
		timer.queue_free()

