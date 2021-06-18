extends Node2D
var mouse_in_area = false
#var set_color_p = get_node("/root/DataBase").color_parties
func _on_Timer_timeout():
	check_party()
	get_node("Timer").queue_free()
func check_party():
	var parties = get_parent().get_parent().parties
	var token = 0
	for i in parties:
		set_color(i, get_node("Party" + str(token)), get_node("Sprite" + str(token)))
		token += 1
func set_color(PartyObj, label, sprite):
	var name_of_party = PartyObj.NameOfParty
	sprite.modulate =  Ideologies.color_parties.get(PartyObj.Ideology)
	label.text = name_of_party + ' (' + PartyObj.Ideology + ') - ' + str(PartyObj.Popularity)

