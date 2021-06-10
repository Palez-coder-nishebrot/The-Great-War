extends Area2D



func _on_Region_body_entered(body):
	body.region = name
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
