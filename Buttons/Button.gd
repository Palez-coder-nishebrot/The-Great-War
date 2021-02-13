extends Button


signal click(obj)

func _on_Button_pressed():
	emit_signal("click", self)
	pass # Replace with function body.
