extends RigidBody2D

var player = null
var bag_cost = 20
var dagger_potion_cost = 5

signal insufficient_funds

func buy_bag():
	if player:
		if player.check_funds() >= bag_cost:
			player.subtract_funds(bag_cost)
			player.has_bag = true
			print("player bought a bag")
		else:
			insufficient_funds.emit()

func buy_potion():
	if player:
		if player.check_funds() >= dagger_potion_cost:
			player.subtract_funds(dagger_potion_cost)
			player.has_potion = true
			print("player bought a dagger potion")
		else:
			insufficient_funds.emit()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_interact_with_shop = true
		body.shop = self
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_interact_with_shop = false
