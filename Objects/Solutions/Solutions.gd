extends Node2D

var ArrOfTextOfButtons: Array = []
var ArrOfButtons: Array = []
func _on_VnutrPolitic_pressed():
	OnButtonPressed("Domestic policy")
	
func _on_VneshPolitic_pressed():
	pass # Replace with function body.


func _on_Economic_pressed():
	OnButtonPressed('Economic')
	
	
func SpawnButtons():
	var pos = Vector2(-208, -208)
	$Exit.visible = true
	for i in ArrOfTextOfButtons:
		var button = load("res://Objects/Solutions/SolutionButton.tscn").instance()
		button.text = i
		button.rect_position = pos
		pos.y += button.rect_size.y
		ArrOfButtons.append(button)
		add_child(button)
	
func CheckTextOnButton(text):
	var solution = SolutionsGlobal.Politic[text]
	var _check_var = CheckCond(solution["Conditions"])
	
func CheckCond(condition):
	match condition[0]:
		"Поддержка красных больше":
			for i in PlayersObj.PlayerObject.parties:
				if i.Ideology == "Коммунисты" or i.Ideology == "Социалисты":
					if i.Popularity >= 20:
						return true
						break
		"Новый претендент на власть":
			PlayersObj.PlayerObject.ChangeRulingParty()
			
		
func OnButtonPressed(tipe):
	$VneshPolitic.visible = false
	$VnutrPolitic.visible = false
	$Economic.visible = false
	$Exit.visible = true
	for i in PlayersObj.PlayerObject.Solutions:
		if PlayersObj.PlayerObject.Solutions[i] == tipe:
			ArrOfTextOfButtons.append(i)
			SpawnButtons()
			break
	


func _on_Exit_pressed():
	for i in ArrOfButtons:
		i.queue_free()
	$VneshPolitic.visible = true
	$VnutrPolitic.visible = true
	$Economic.visible = true
	$Exit.visible = false
