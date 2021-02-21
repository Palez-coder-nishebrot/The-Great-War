extends Node2D

var WORD = null
var TIMER = null
var BE = false
var what_we_level_up = [null, null,null, null, null] #"tanks","Armored car","Motorized infantry","infantry","aerial tech",
var texttanks = {
1: "Танк Вездеход",
2: "Тяжелый Ромбовидный Танк",
3: "Тяжелый Танк Броненосец I",
4: "Тяжелый Танк Броненосец II",
5: "Танка Броненосец III",
}
var textArmoredCarVARstart = {
1: "Первый образец бронеавтомобиля",
2: "Бронеавтомобиль",
3: "Зенитка",
4: "Земля1",
5: "Земля2",
6: "Артеллерийский грузовик",
7: "Искоринитель",
}
var textMI = {
1: "Открытый легкий грузовик",
2: "Закрытый легкий грузовик",
3: "Грузовик"
}
var textaerial_tech = {
1: "Аэроплан",
2: "Аэроплан с пулеметом",
3: "Бронированный аэроплан",
4: "Истребитель",
5: "Тяжелый бомбардировщик"
}
var infantry = {
1: "Образец полуавтоматической винтовки",
2: "Образец автоматической винтовки",
3: "Полуавтоматическая винтовка",
4: "Полуавтоматическая винтовка с расширенным магазином",
5: "Автоматическая винтовка Хьюиса",
6: "Ручной пулемет",
7: "Автоматическая винтовка",
}
var levels = {
"tanks": 1,
"Armored car": 1,
"Motorized infantry": 1,
"infantry": 1,
"aerial tech": 1,
}

func _ready():
	get_node("Label2").visible = false

func _on_tank_area_mouse_entered():
	on_area_mouse_entered("tanks")
func _on_tank_area_mouse_exited():
	get_node("Label2").visible = false

func on_area_mouse_entered(word):
	get_node("Label2").visible = true
	if word == "tanks":
		print(texttanks.get(levels.get(word)))
		get_node("Label2").text = texttanks.get(levels.get(word))
	elif word == "Armored car":
		get_node("Label2").text = textArmoredCarVARstart.get(levels.get(word))
	elif word == "Motorized infantry":
		get_node("Label2").text = textMI.get(levels.get(word))
	elif word == "infantry":
		get_node("Label2").text = infantry.get(levels.get(word))
	else: #"aerial tech"
		get_node("Label2").text = textaerial_tech.get(levels.get(word))


func _on_armored_car_area_mouse_entered():
	on_area_mouse_entered("Armored car")
func _on_armored_car_area_mouse_exited():
	get_node("Label2").visible = false
func _on_motorized_infantry_area_mouse_entered():
	on_area_mouse_entered("Motorized infantry")
func _on_motorized_infantry_area_mouse_exited():
	get_node("Label2").visible = false
func _on_infantry_area_mouse_entered():
	on_area_mouse_entered("infantry")
func _on_infantry_area_mouse_exited():
	get_node("Label2").visible = false
func _on_aerial__tech_area_mouse_entered():
	on_area_mouse_entered("aerial tech")
func _on_aerial__tech_area_mouse_exited():
	get_node("Label2").visible = false



func _on_Tanks_pressed():
	spawn_timer("tanks", texttanks)

func _on_Armored_car_pressed():
	spawn_timer("Armored car", textArmoredCarVARstart)
	
func _on_Motorized_infantry_pressed():
	spawn_timer("Motorized infantry", textMI)

func _on_infantry_pressed():
	spawn_timer("infantry", infantry)

func _on_aerial2_pressed():
	spawn_timer("aerial tech", textaerial_tech)


func spawn_timer(word, list):
	WORD = word
	if list.size() != levels.get(word):
		spawn()
		
func spawn():
	if BE == false:
		var obj = Timer.new()
		obj.connect("timeout", self, "level_up")
		obj.name = "TIMER"
		add_child(obj)
		obj.start(2)
		TIMER = get_node("TIMER")
		BE = true
func level_up():
	TIMER.queue_free()
	BE = false
	if WORD == "tanks":
		levels[WORD] += 1
		get_node("Tanks").text = texttanks.get(levels.get("tanks"))
	elif WORD == "aerial tech":
		levels[WORD] += 1
		get_node("aerial2").text = textaerial_tech.get(levels.get("aerial tech"))
	elif WORD == "infantry":
		levels[WORD] += 1
		get_node("infantry").text = infantry.get(levels.get("infantry"))
	elif WORD == "Motorized infantry":
		levels[WORD] += 1
		get_node("Motorized infantry").text = textMI.get(levels.get("Motorized infantry"))
	else:
		levels[WORD] += 1
		get_node("Armored car").text = textArmoredCarVARstart.get(levels.get("Armored car"))
