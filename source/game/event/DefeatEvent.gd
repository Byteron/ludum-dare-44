extends Event

func _execute():
	get_tree().reload_current_scene()

func _on_TickTimer_timeout() -> void:
	if Global.Game.budget <= 0:
		._on_TickTimer_timeout()