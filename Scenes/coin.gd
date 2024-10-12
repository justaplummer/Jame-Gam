extends Area2D

var value = 1
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.add_to_wallet(value)
		queue_free()
