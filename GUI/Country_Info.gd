extends Node2D

func _ready():
	visible = false
# warning-ignore:return_value_discarded
	get_parent().get_node("CanvasLayer/Country").connect("pressed", self, "Get_Country_info")

func Get_Country_info():
	if visible == true:
		visible = false
	else:
		visible = true
	var get_p = 1
	for i in range(5):
		var party = get_parent().parties.get(i)
		print(party)
		get_node("part" + str(get_p)).text = party[0] + " - " + party[1]
		get_p += 1
