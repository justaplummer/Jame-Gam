extends CharacterBody2D
@onready var camera_2d: Camera2D = $Camera2D

@export var dagger_scene : PackedScene
const SPEED = 200.0
	
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED

func _physics_process(_delta):
	get_input()
	shoot_projectile()
	move_and_slide()

func shoot_projectile():
	if Input.is_action_just_pressed("attack") || Input.is_action_just_pressed("ui_accept"):
		var dagger = dagger_scene.instantiate()
		var mouse_rotation = get_local_mouse_position().angle_to(Vector2.RIGHT) * -1
		dagger.set_rotation_from_player(mouse_rotation,position)
		get_parent().add_child(dagger)
#method of movement that blends 8 way and looking with mouse. Might use this later so that we can inlcude aiming.
#func get_input():
	#look_at(get_global_mouse_position())
	#var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#velocity = input_direction * SPEED
#
#func _physics_process(delta):
	#get_input()
	#move_and_slide()
