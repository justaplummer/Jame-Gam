extends Area2D

signal no_bag_notification

@export var gem_name: String
@export var sprite_image: Texture2D

func _ready() -> void:
	$Sprite2D.texture = sprite_image

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_bag:
			body.add_gem(gem_name)
			queue_free()
		else:
			no_bag_notification.emit()
