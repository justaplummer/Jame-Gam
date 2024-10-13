extends Area2D

var SPEED = 350
var direction = Vector2.RIGHT.rotated(rotation)
var direction_set = false

func _physics_process(delta: float) -> void:
	if direction_set:
		global_position += SPEED * direction * delta

func set_rotation_from_player(rot, pot):
	position = pot
	rotation = rot
	direction = Vector2.RIGHT.rotated(rotation)
	direction_set = true

func destroy():
	queue_free()



func _on_area_entered(area: Area2D) -> void:
	print(area)
	if area.is_in_group("player"):
		pass
	elif area.is_in_group("enemy"):
		area.on_hit()
		destroy()
	elif area.is_in_group("ward"):
		pass
	else:
		destroy()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
	elif body.is_in_group("enemy"):
		body.on_hit()
		destroy()
	else:
		destroy()
