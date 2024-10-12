extends Node

@onready var hud: Hud = $CanvasLayer/HUD
@onready var main_menu: Control = $CanvasLayer/MainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hud.toggle_timer()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_parent().get_tree().quit()
	if Input.is_action_just_pressed("menu"):
		toggle_menu()

func toggle_menu():
	#how to freeze player control and enemy movement when menu is open?
	main_menu.visible = !main_menu.visible
	hud.toggle_timer()
