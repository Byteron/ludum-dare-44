extends Control

onready var tween = $Tween
onready var budget_progress = $HBoxContainer/BugdetProgress

func set_max_budget(max_budget):
	budget_progress.max_value = max_budget

func update_budget(new_budget):
	var color = null

	if budget_progress.value > new_budget:
		color = Color("FF0000")
	else:
		color = Color("00FF00")

	budget_progress.value = new_budget
	tween.interpolate_property(budget_progress, "modulate", color, Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()