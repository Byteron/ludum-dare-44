extends CanvasLayer

const PopLabel = preload("res://source/interface/components/PopLabel.tscn")
const BuildingBar = preload("res://source/interface/components/BuildingBar.tscn")

signal building_invested(building)
signal hint_purchased

onready var top_panel = $TopPanel
onready var investment_popup = $InvestmentPopup
onready var info_popup = $InfoPopup
onready var newspaper = $Newspaper
onready var name_panel = $NamePanel

func _ready():
	newspaper.show()

func add_income_label(income, position):
	var label = PopLabel.instance()
	label.rect_position = position
	label.value = income
	get_parent().add_child(label)

func add_building_bar(time, hook):
	var bar = BuildingBar.instance()
	bar.hook = hook
	bar.time = time
	get_parent().add_child(bar)

func show_article(event):
	newspaper.show_article(event)
	name_panel.text = ""
	name_panel.fade_out()

func show_investment_popup(structure):
	investment_popup.structure = structure
	investment_popup.popup_centered()

func show_info_popup(structure):
	info_popup.structure = structure
	info_popup.popup_centered()

func set_max_budget(max_budget):
	top_panel.set_max_budget(max_budget)

func update_balance(balance):
	top_panel.update_balance(balance)

func update_budget(new_budget):
	top_panel.update_budget(new_budget)

func show_name_panel(building_name):
	name_panel.text = building_name
	name_panel.fade_in()

func clear_name_panel():
	name_panel.text = ""
	name_panel.fade_out()

func _on_InvestmentPopup_invested(building):
	emit_signal("building_invested", building)

func _on_TopPanel_hint_purchased():
	emit_signal("hint_purchased")
	var next_hint = Hints.get_next_hint()
	$Letter.show_article(next_hint)