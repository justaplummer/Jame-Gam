extends RigidBody2D


func update_ward(ruby,saph,emer):
	$ruby.visible = ruby
	$emer.visible = emer
	$saph.visible = saph

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_interact_with_ward = true
		body.ward = self


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_interact_with_ward = false
