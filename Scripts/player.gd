extends CharacterBody2D

signal update_wallet

@onready var camera_2d: Camera2D = $Camera2D
@onready var dagger_throw_cooldown: Timer = $Dagger_Throw_Cooldown

@export var dagger_scene : PackedScene
const SPEED = 200.0
var can_throw_dagger = true
var wallet = 0
	
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED

func _physics_process(_delta):
	get_input()
	shoot_projectile()
	move_and_slide()

func shoot_projectile():
	if not can_throw_dagger: return
	if Input.is_action_just_pressed("attack") || Input.is_action_just_pressed("ui_accept"):
		add_dagger()
		can_throw_dagger = false
		dagger_throw_cooldown.start(0.75)
		
func add_dagger():
	var dagger = dagger_scene.instantiate()
	var mouse_rotation = get_local_mouse_position().angle_to(Vector2.RIGHT) * -1
	dagger.set_rotation_from_player(mouse_rotation,position)
	get_parent().add_child(dagger)

func _on_dagger_throw_cooldown_timeout() -> void:
	can_throw_dagger = true

func add_to_wallet(inc):
	wallet += inc
	update_wallet.emit()
	#hud.set_wallet(wallet)
