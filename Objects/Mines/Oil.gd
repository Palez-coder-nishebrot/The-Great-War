extends Area2D

func _on_Oil_area_entered(area):
	if area.get_parent().get_groups() == ["Tile"]:
		var timer = Timer.new()
		add_child(timer)
		timer.start(5.0)
		yield(timer, "timeout")
		area.get_parent().booty = "Нефть"
		
		Global.connect("new_day_signal", area.get_parent(), "BootyResources")
		
		PlayersObj.playersObj.get(area.get_parent().part_of)[1].arr_of_booty.append("Нефть")
		
		
		timer.queue_free()
		queue_free()
