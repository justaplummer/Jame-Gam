class_name Hud extends Control
@onready var label_stopwatch: Label = $Label_Stopwatch
@onready var stopwatch: Stopwatch = $Stopwatch
@onready var label_num_keys: Label = $Label_Num_Keys
@onready var l_edit_player_name: LineEdit = $End_Of_Game/LEdit_player_name
@onready var button: Button = $End_Of_Game/Button
@onready var label_wallet: Label = $Label_Wallet

func _ready() -> void:
	set_num_keys(0)
	set_wallet(0)

func _process(_delta: float) -> void:
	label_stopwatch.text = stopwatch.time_to_string()
	
func set_num_keys(number):
	label_num_keys.text = str(number) + "/3 Keys"

func game_over():
	stopwatch.stopped = true
	l_edit_player_name.visible = true
	button.visible = true
	$End_Of_Game/Label.visible = true
	
func toggle_timer():
	stopwatch.stopped = !stopwatch.stopped

func set_wallet(number):
	label_wallet.text = "Wallet: " + str(number)

func set_label_need_bag():
	$label_need_bag.visible = true
	$hide_need_bag.start(5)


func _on_hide_need_bag_timeout() -> void:
	$label_need_bag.visible = false
	
func set_low_funds_warning():
	$label_low_funds.visible = true
	$hide_low_funds.start(5)


func _on_hide_low_funds_timeout() -> void:
	$label_low_funds.visible = false
