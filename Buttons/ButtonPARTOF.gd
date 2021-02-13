extends Button


signal start(TEXT)

func _on_Button3_pressed():
	emit_signal("start", text)
