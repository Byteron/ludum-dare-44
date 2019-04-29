extends Event

func _execute():
	Scene.change(Scene.TitleScreen)

func _on_TickTimer_timeout() -> void:
	if Global.Game.budget >= 480000:
		._on_TickTimer_timeout()