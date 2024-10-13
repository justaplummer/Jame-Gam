extends CharacterBody2D

signal update_wallet

@onready var camera_2d: Camera2D = $Camera2D
@onready var dagger_throw_cooldown: Timer = $Dagger_Throw_Cooldown

@export var dagger_scene : PackedScene
var ward = null
var shop = null
const SPEED = 100.0
var can_throw_dagger = true
var wallet = 0
#we will turn these true when we enter the area near the object
var can_interact_with_ward = false
var can_interact_with_shop = false
#we will turn these true when the player has picked them up
var has_ruby = false
var has_emer = false
var has_saph = false
#these are power ups
var has_bag = false
var has_potion = false
	
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED

func _unhandled_input(_event: InputEvent) -> void:
	if can_interact_with_ward:
		if Input.is_action_just_pressed("interact"):
			ward.update_ward(has_ruby,has_saph,has_emer)
	if can_interact_with_shop:
		if Input.is_action_just_pressed("buy_bag"):
			shop.buy_bag()
		if Input.is_action_just_pressed("buy_dagger_potion"):
			shop.buy_potion()

func add_gem(name):
	if name == "Ruby":
		has_ruby = true
	if name == "Emer":
		has_emer = true
	if name == "Saph":
		has_saph = true

func check_funds():
	return wallet
	
func subtract_funds(amount):
	wallet -= amount
	update_wallet.emit()

func _physics_process(_delta):
	get_input()
	shoot_projectile()
	move_and_slide()

func shoot_projectile():
	if not can_throw_dagger: return
	if Input.is_action_just_pressed("attack") || Input.is_action_just_pressed("ui_accept"):
		add_dagger()
		can_throw_dagger = false
		if has_potion:
			dagger_throw_cooldown.start(0.75/2)
		else:
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
