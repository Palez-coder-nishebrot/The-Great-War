extends Node

signal Researchcompleted
var data_of_end
func end(obj_button):
	for i in obj_button.get_children():
		if i is TextureButton:
			i.status = true
	obj_button.status = false
	print('Исследование завершено')


func cavalry(_text, _part_of,_obj_button):
	print('Недоделано!')
func AvtWepon(text, part_of,obj_button):
	data_of_end = Global.schedule_date(2)
	Global.connect("new_day_timer", self, "PlusDay")
	yield(self, "Researchcompleted")
	if DataBaseResearch.weaponAvtLevel[text] != []:
		var SS = DataBaseResearch.weaponAvtLevel[text]
		var SSelements = ['weapon']
		for i in SS:
			SSelements.append(i)
		PlayersObj.playersObj[part_of][1].research_wapon[DataBaseResearch.weaponAvtLevel[text]] = SSelements
		end(obj_button)
func PolAvtWepon(text, part_of,obj_button):
	data_of_end = Global.schedule_date(2)
	Global.connect("new_day_timer", self, "PlusDay")
	yield(self, "Researchcompleted")
	if DataBaseResearch.polAvtWeaponLevel[text] != []:
		var SS = DataBaseResearch.polAvtWeaponLevel[text]
		var SSelements = ['weapon']
		for i in SS:
			SSelements.append(i)
		PlayersObj.playersObj[part_of][1].research_wapon[DataBaseResearch.polAvtWeaponLevel[text]] = SSelements
		end(obj_button)
func artillery(text, part_of,obj_button):
	data_of_end = Global.schedule_date(2)
	Global.connect("new_day_timer", self, "PlusDay")
	yield(self, "Researchcompleted")
	var SS = DataBaseResearch.artilleryLevel[text]
	var SSelements = ['weapon_support']
	for i in SS:
		SSelements.append(i)
	PlayersObj.playersObj[part_of][1].research_wapon[DataBaseResearch.artilleryLevel[text]] = SSelements
	end(obj_button)
func grenades(text, part_of,obj_button):
	data_of_end = Global.schedule_date(2)
	Global.connect("new_day_timer", self, "PlusDay")
	yield(self, "Researchcompleted")
	var SS = DataBaseResearch.grenadesLevel[text][1]
	var SSelements = ['weapon_support']
	for i in SS:
		SSelements.append(i)
	PlayersObj.playersObj[part_of][1]
	PlayersObj.playersObj[part_of][1].research_wapon[DataBaseResearch.grenadesLevel[text]] = SSelements
	end(obj_button)
func FireSupport(text, part_of,obj_button):
	data_of_end = Global.schedule_date(2)
	Global.connect("new_day_timer", self, "PlusDay")
	yield(self, "Researchcompleted")
	var SS = DataBaseResearch.fireSupportLevel[text]
	var SSelements = ['weapon_support']
	for i in SS:
		SSelements.append(i)
	print(PlayersObj.playersObj[part_of])
	PlayersObj.playersObj[part_of][1].research_wapon[DataBaseResearch.fireSupportLevel[text]] = SSelements
	end(obj_button)

func PlusDay(new_data):
	if new_data["day"] == data_of_end["day"] and new_data["month"] == data_of_end["month"] and new_data["year"] == data_of_end["year"]:
		Global.disconnect("new_day_timer", self, "PlusDay")
		emit_signal("Researchcompleted")
		

