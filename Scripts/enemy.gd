extends RigidBody2D


func on_hit():
	print("enemy recieved hit!")
	queue_free()
