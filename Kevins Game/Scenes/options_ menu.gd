extends Control
 

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	



func _on_control_pressed():
	get_tree().change_scene_to_file("res://Scenes/controls.tscn")
