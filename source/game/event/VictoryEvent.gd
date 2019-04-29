extends Event

func _execute():
	Scene.change(Scene.TitleScreen)

func _on_TickTimer_timeout() -> void:
	if Global.Game.budget >= 500000:
		._on_TickTimer_timeout()