extends Node

signal new_day(info)
signal new_day_signal
signal new_day_timer(info)
var speed_of_game:float = 30.0



func _process(delta):
	_on_time_of_game_timeout()
	set_process(false)
	yield(get_tree().create_timer(speed_of_game * delta), "timeout")
	set_process(true)

var time_of_game: Dictionary = {
'day': 30,
'month': 1,
'year': 1918}

func _on_time_of_game_timeout():
	if time_of_game["day"] == 31:
		time_of_game["day"] = 1
		time_of_game["month"] += 1
		if time_of_game["month"] > 12:
			time_of_game["month"] = 1
			time_of_game["year"] += 1
	else:
		time_of_game["day"] += 1
	var day = str(time_of_game["day"])
	var month = get_node("/root/DataBase").month_list[time_of_game["month"] - 1]
	var year = str(time_of_game["year"])
	emit_signal("new_day", "День: " + day + "\n Месяц: " + month + "\n Год: " + year)
	emit_signal("new_day_timer", time_of_game)
	emit_signal("new_day_signal")


func schedule_date(time):
	var today_data:Dictionary = time_of_game.duplicate(true)
	for _i in range(time):
		if today_data["day"] == 31:
			today_data["day"] = 1
			today_data["month"] += 1
			if today_data["month"] > 12:
				today_data["month"] = 1
				today_data["year"] += 1
		else:
			today_data["day"] += 1 
	return today_data
