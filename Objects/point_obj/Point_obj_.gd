extends KinematicBody2D

const stop_pos: int = 1
const speed: int = 1000
var point: Vector2
var parent: Object
func _process(_delta):
	if position.distance_to(point) > stop_pos:
		var direction = point - position
		var norm_direction = direction.normalized()
		move_and_slide(norm_direction * speed)
	else:
		parent.move_to_point()
		queue_free()
		

func _on_Area2D_body_entered(body):
	parent.move_arr.append(body)
	if body.position == point:
		parent.move_to_point()
		queue_free()

