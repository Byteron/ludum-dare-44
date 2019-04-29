extends Control

signal hint_purchased

onready var tween = $Tween
onready var budget_progress = $HBoxContainer/BudgetProgress
onready var budget_label = $HBoxContainer/BudgetLabel
onready var balance_label = $HBoxContainer/BalanceLabel
onready var hint_button = $HintButton

func _ready():
	visible = true

func set_max_budget(max_budget):
	budget_progress.max_value = max_budget

func update_budget(new_budget):
	var color = null

	if budget_progress.value > new_budget:
		color = Color("FF0000")
	else:
		color = Color("00FF00")

	budget_progress.value = new_budget
	budget_label.text = "%s$" % Helper.beautify_number(new_budget)

	tween.interpolate_property(budget_progress, "modulate", color, Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(budget_label, "modulate", color, Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

	hint_button.disabled = (new_budget < Hints.cost_per_hint)

func update_balance(balance):
	var color = null
	var text = ""
	if balance < 0:
		color = Color("FF0000")
		text = "-%s$/m"
	else:
		text = "+%s$/m"
		color = Color("00FF00")

	balance_label.text = text % Helper.beautify_number(balance)
	balance_label.modulate = color

func _on_HintButton_pressed():
	emit_signal("hint_purchased")