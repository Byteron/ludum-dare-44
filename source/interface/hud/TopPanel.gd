extends Control

onready var tween = $Tween
onready var budget_label = $HBoxContainer/BudgetLabel

func update_budget(new_budget):
	budget_label.text = "Budget: %d" % new_budget
	tween.interpolate_property(budget_label, "modulate", Color("FF0000"), Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()