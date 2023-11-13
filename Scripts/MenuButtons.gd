extends VBoxContainer


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Screens/Main_Scene.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Screens/Options_Scene.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Screens/Credits_Scene.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
