extends Control

func _on_Game_pressed() -> void:
	Scene.change(Scene.Game)

func _on_Quit_pressed() -> void:
	get_tree().quit()