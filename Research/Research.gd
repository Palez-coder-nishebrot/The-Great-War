extends Node2D

var texttanks = {
1: "GGGGG",
2: "Танк Вездеход (оснащен одним пулеметом, экипаж: 1)",
3: "Мощный двигатель",
4: "Тяжелый Ромбовидный Танк (оснащен 2 пулеметами, экипаж: 4)",
5: "Тяжелый Танк Карл I (оснащен 2 пулеметами и одной пушкой, экипаж: 6)",
6: "Тяжелый Танк Карл II (тоже самое, что и 5 только увеличена броня)",
7: "Танка Карл III (тоже самое, что и 4 только увеличена скорость)",
}
var levels = {
"tanks": 1,
"Armored car": 1,
"Motorized infantry": 1,
"infantry": 1,
"aerial": 1,
}

func _ready():
	get_node("Label").visible = false

func _on_tank_area_mouse_entered():
	on_area_mouse_entered("tanks")
func _on_tank_area_mouse_exited():
	get_node("Label").visible = false

func on_area_mouse_entered(word):
	get_node("Label").visible = true
	var token = levels.get(word)
	var _token2 = str(token)
	if word == "tanks":
		$Label/Label.set_text(texttanks.get(token))
