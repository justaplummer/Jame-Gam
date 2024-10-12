extends RigidBody2D

@onready var progress_bar: ProgressBar = $ProgressBar

var curHealth = 0
var maxHealth = 5
var speed = 20
var direction = Vector2(100,100)
var player
var chase_player = false

func _ready() -> void:
	curHealth = maxHealth
	progress_bar.max_value = maxHealth
	update_progress_bar()
	lock_rotation = true

func _physics_process(delta: float) -> void:
	if chase_player and player:
		position = position.move_toward(player.position,speed * delta)
	else:
		position = position.move_toward(direction,speed * delta)

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

#currently these are also detecting other zombies but whatever
func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		direction = body.position
		chase_player = true
		#with my position and the player position I should be able to create a normalized vector in the right direction

func _on_player_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		direction = Vector2.ZERO#need to replace this with some kind of meandering but that's fine
		player = null#could not set this to null so that they will chase you endlessly lol
		chase_player = false
