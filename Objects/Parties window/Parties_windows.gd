extends Node2D
var mouse_in_area = false
const set_color_p = {
'Национализм':  Color( 0.65, 0.16, 0.16, 1 ),
"Коммунизм": Color( 1, 0, 0, 1 ),
"Консерватизм": Color( 0, 0.5, 0.5, 1 ),
"Демократия":Color( 0, 0, 1, 1 ) ,
"Социал-Демократия": Color( 0.63, 0.13, 0.94, 1 ),
"Центризм": Color( 0.75, 0.75, 0.75, 1 ),
"Анархизм": Color( 0, 1, 0, 1 ),
"Монархизм": Color( 1, 0.5, 0.31, 1 ),
"Серо-гвардейцы":  Color( 0.65, 0.16, 0.16, 1 ),
}

func _on_Timer_timeout():
	check_party()
	get_node("Timer").queue_free()
func check_party():
	var parties = get_parent().get_parent().parties
	var token = 0
	for i in parties:
		set_color(i, get_node("Party" + str(token)), get_node("Sprite" + str(token)))
		token += 1
func set_color(tipe_of_party, label, sprite):
	print(sprite)
	var parties = get_parent().get_parent().parties
	sprite.modulate =  set_color_p.get(tipe_of_party)
	label.text = '(' + tipe_of_party + ') - ' +  parties.get(tipe_of_party)

