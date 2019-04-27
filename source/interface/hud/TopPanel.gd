extends Control

onready var tween = $Tween
onready var budget_progress = $HBoxContainer/BugdetProgress

func update_budget(new_budget):
	budget_progress.value = new_budget
	tween.interpolate_property(budget_progress, "modulate", Color("FF0000"), Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()