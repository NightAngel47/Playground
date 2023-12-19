class_name MainMenu
extends Panel

const first_level = preload("res://Scenes/Levels/level_test.tscn")

func _on_button_play_pressed():
	get_tree().change_scene_to_packed(first_level)


func _on_button_quit_pressed():
	get_tree().quit()
