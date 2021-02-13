extends Node

var for_start
var speed = 1

var color = {"Red":  Color(1.0, 0, 0),
"Orange":            Color(1, 0.678431, 0),
"Brown":             Color(0.367188, 0.180725, 0),
"Turquoise":        Color(0, 1, 0.671875),
"Purple":           Color(0.523438, 0, 1),
"Purple-Red":        Color(1, 0, 0.513726),
"Blue":              Color(0, 0.062745, 1)
}
var country = {"Adamanty": color.get("Orange"), #Равнинная республика
"Tsarstvo Bascany":       color.get("Red"), # Королевство Истленд
"Bascany Protectorat":     color.get("Purple-Red"), #Протекторат Истленд 
"Nasadry":                 color.get("Turquoise"), #Береговое королевство 
"Gorny":                   color.get("Blue") #Саузения 
}

var Use_colour = ["Purple", "Turquoise", "Brown", "Orange"]

var weapon_and_attak = {
	"Nivel's gun": [2, 1],
}
var weapon_podd = {
	"trench knife": [1, 0]
}

var parties_for_randi = {
	1: ["Социал-демократическая партия рабочих", "Социал-демократия"],
	2: ["Партия прогресса", "Социал-демократия"],
	3: ["Национал-социалистическая свободная коммуна", "Анархизм"],
	4: ["Освободительная национальная партия", "Анархизм"],
	5: ["Национальная партия военных", "Фашизм"],
	6: ["Национальные раволюционеры", "Фашизм"],
	7: ["Центристская трудовая партия", "Центризм"],
	8: ["Партия центра", "Центризм"],
	9: ["Национал-коммунистиченская партия", "Коммунизм"],
	10: ["Левая рука", "Коммунизм"],
	11: ["Социал-республиканская партия", "Социализм"],
	12: ["Крестьяне и рабочие", "Социализм"]
}

var contries = ["Adamanty", "Tsarstvo Bascany", "Bascany Protectorat", "Nasadry", "Gorny"]
