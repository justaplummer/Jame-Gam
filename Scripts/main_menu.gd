extends Control

signal toggle_leaderboard

func _on_leaderboard_pressed() -> void:
	toggle_leaderboard.emit()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_start_game_pressed() -> void:
	#would need to update path if we change what tree the menu is on
	get_node("/root/GameController").toggle_menu()
