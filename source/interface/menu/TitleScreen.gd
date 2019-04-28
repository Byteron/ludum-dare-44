extends Control

func _on_Game_pressed():
	Scene.change(Scene.Game)

func _on_Quit_pressed():
	get_tree().quit()