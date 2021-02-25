extends Button
signal click(Text)

func _on_Button_for_check_unit_pressed():
	emit_signal("click", text)
