extends RigidBody2D

@onready var progress_bar: ProgressBar = $ProgressBar
@export var coin_scene : PackedScene

var curHealth = 0
var maxHealth = 5
var speed = 10
var direction = Vector2(randf_range(-50,50),randf_range(-50,50))
var player
var chase_player = false
var start_position = Vector2.ZERO
var update_position = false

func _ready() -> void:
	curHealth = maxHealth
	progress_bar.max_value = maxHealth
	update_progress_bar()
	lock_rotation = true
	$Update_Position.start(randf_range(7,12))

func _physics_process(delta: float) -> void:
	if chase_player and player:
		position = position.move_toward(player.position,speed * delta)
	else:
		if direction:
			position = position.move_toward(direction,speed * delta)

func set_direction():
	direction.x = start_position.x + randf_range(-50,50)
	direction.y = start_position.y + randf_range(-50,50)

func on_hit():
	curHealth -= 1
	update_progress_bar()
	if curHealth <= 0:
		call_deferred("enemy_killed")
		
func enemy_killed():
	var coin = coin_scene.instantiate()
	coin.position = position
	get_parent().add_child(coin)
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


func _on_update_position_timeout() -> void:
	direction = set_direction()
	$Update_Position.start(randf_range(7,12))
