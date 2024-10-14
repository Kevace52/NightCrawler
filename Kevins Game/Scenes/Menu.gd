extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")



func _on_option_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_ menu.tscn")




func _on_button_pressed():
	get_tree().quit()
