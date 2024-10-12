extends Control


func _on_start_game_pressed() -> void:
	pass
	#hide menu probably or load first scene


func _on_leaderboard_pressed() -> void:
	pass
	#I think we probably want to ppause the timer and 
	#get_tree().change_scene_to_file("res://Scenes/leaderboard.tscn")




func _on_quit_pressed() -> void:
	get_tree().quit()
