extends PopupPanel
class_name BuildingPopup

var building setget _set_building

onready var name_label = $CenterContainer/VBoxContainer/Name
onready var cost_label = $CenterContainer/VBoxContainer/CostLabel
onready var revenue_label = $CenterContainer/VBoxContainer/RevenueLabel
onready var income_label = $CenterContainer/VBoxContainer/IncomeLabel
onready var upkeep_label = $CenterContainer/VBoxContainer/UpkeepLabel
onready var flavour_label = $CenterContainer/VBoxContainer/FlavourLabel

func _set_building(slug):
	building = slug
	name_label.text = str(building.building_name)
	if building.type == Global.Game.discount_type:
		cost_label.text = "Investment: %s$" % Helper.beautify_number(int(building.cost * Global.Game.discount))
	else:
		cost_label.text = "Investment: %s$" % Helper.beautify_number(building.cost)

	if building.revenue_per_housing:
		revenue_label.text = "Max Revenue: %s$/m" % Helper.beautify_number(int((building.revenue * 8 / building.tick_time) * 60))
	else:
		revenue_label.text = "Max Revenue: %s$/m" % Helper.beautify_number(int((building.revenue / building.tick_time) * 60))
	income_label.text = "Income: %s$/m" % Helper.beautify_number(int((building._calculate_income() / building.tick_time) * 60))
	upkeep_label.text = "Upkeep: %s$/m" % Helper.beautify_number(int((building.upkeep / building.tick_time) * 60))

	flavour_label.text = str(building.flavour_text)