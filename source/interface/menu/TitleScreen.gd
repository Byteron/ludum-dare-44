extends Control

func _on_Game_pressed():
	Audio.play("click")
	Audio.fade_out("menu_music")
	$StartTimer.start()

func _on_Quit_pressed():
	get_tree().quit()

func _on_StartTimer_timeout():
	Scene.change(Scene.Game)

func _ready():
	Audio.play("menu_music")