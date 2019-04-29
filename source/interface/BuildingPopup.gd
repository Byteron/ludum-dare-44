extends PopupPanel

signal invested(building)

var building setget _set_building

onready var name_label = $VBoxContainer/Name
onready var cost_label = $VBoxContainer/CostLabel
onready var revenue_label = $VBoxContainer/RevenueLabel
onready var income_label = $VBoxContainer/IncomeLabel
onready var upkeep_label = $VBoxContainer/UpkeepLabel
onready var flavour_label = $VBoxContainer/FlavourLabel

func _set_building(slug):
	building = slug
	name_label.text = str(building.building_name)
	cost_label.text = "Investment: %s$" % Helper.beautify_number(building.cost)

	if building.revenue_per_housing:
		revenue_label.text = "Max Revenue: %s$" % Helper.beautify_number(building.revenue * 8)
	else:
		revenue_label.text = "Max Revenue: %s$" % Helper.beautify_number(building.revenue)
	income_label.text = "Current Income: %s$" % Helper.beautify_number(building._calculate_income())
	upkeep_label.text = "Upkeep: %s$" % Helper.beautify_number(building.upkeep)

	flavour_label.text = str(building.flavour_text)

func _on_InvestButton_pressed():
	Audio.play("confirm")
	emit_signal("invested", building)
	building = null
	hide()

func _on_BuildingPopup_about_to_show():
	$VBoxContainer/InvestButton.disabled = building.cost > Global.Game.budget