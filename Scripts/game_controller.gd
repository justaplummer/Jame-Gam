extends Node

@onready var hud: Hud = $CanvasLayer/HUD
@onready var main_menu: Control = $CanvasLayer/MainMenu
@export var enemy_scene: PackedScene
@onready var player: CharacterBody2D = $Player

var max_zombies = 200
var cur_zombies = 0
var hide_menu_on_on_start = true#set to false for normal running

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hud.toggle_timer()
	if hide_menu_on_on_start:
		toggle_menu()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_parent().get_tree().quit()
	if Input.is_action_just_pressed("menu"):
		toggle_menu()

func toggle_menu():
	#how to freeze player control and enemy movement when menu is open?
	main_menu.visible = !main_menu.visible
	hud.toggle_timer()


func _on_spawn_enemy_pressed() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)


func _on_player_update_wallet() -> void:
	hud.set_wallet(player.wallet)

func display_no_bag_warning():
	hud.set_label_need_bag()

func _on_gem_emer_no_bag_notification() -> void:
	display_no_bag_warning()

func _on_gem_saph_no_bag_notification() -> void:
	display_no_bag_warning()

func _on_gem_ruby_no_bag_notification() -> void:
	display_no_bag_warning()


func _on_spawn_zombies_at_ward_timeout() -> void:
	if cur_zombies >= max_zombies: return
	cur_zombies += 1
	var enemy = enemy_scene.instantiate()
	enemy.start_position = $Zombie_Spawn_Ward.position
	enemy.position = $Zombie_Spawn_Ward.position
	add_child(enemy)
	$Zombie_Spawn_Ward/Spawn_Zombies_At_Ward.start(randf_range(5,10))


func _on_ruby_timer_timeout() -> void:
	if cur_zombies >= max_zombies: return
	cur_zombies += 1
	var enemy = enemy_scene.instantiate()
	enemy.start_position = $zombie_spawn_ruby.position
	enemy.position = $zombie_spawn_ruby.position
	add_child(enemy)
	$zombie_spawn_ruby/ruby_timer.start(randf_range(25,45))


func _on_saph_timer_timeout() -> void:
	if cur_zombies >= max_zombies: return
	cur_zombies += 1
	var enemy = enemy_scene.instantiate()
	enemy.start_position = $zombie_sapwn_saph.position
	enemy.position = $zombie_sapwn_saph.position
	add_child(enemy)
	$zombie_sapwn_saph/saph_timer.start(randf_range(25,45))


func _on_emer_timer_timeout() -> void:
	if cur_zombies >= max_zombies: return
	cur_zombies += 1
	var enemy = enemy_scene.instantiate()
	enemy.start_position = $zombie_sapwn_emer.position
	enemy.position = $zombie_sapwn_emer.position
	add_child(enemy)
	$zombie_sapwn_emer/emer_timer.start(randf_range(25,45))


func _on_player_insufficient_funds() -> void:
	hud.set_low_funds_warning()


func _on_shop_insufficient_funds() -> void:
	hud.set_low_funds_warning()


func _on_ward_game_over() -> void:
	hud.game_over()
