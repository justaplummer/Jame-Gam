extends RigidBody2D

@onready var progress_bar: ProgressBar = $ProgressBar

var curHealth = 0
var maxHealth = 5

func _ready() -> void:
	curHealth = maxHealth
	progress_bar.max_value = maxHealth
	update_progress_bar()

func on_hit():
	curHealth -= 1
	print("enemy health = ", curHealth)
	update_progress_bar()
	if curHealth <= 0:
		enemy_killed()
		
func enemy_killed():
	queue_free()
	
func update_progress_bar():
	progress_bar.set_value_no_signal(curHealth)
