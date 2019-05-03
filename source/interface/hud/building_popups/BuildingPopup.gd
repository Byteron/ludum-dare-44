extends PopupPanel
class_name BuildingPopup

var structure setget _set_structure

onready var name_label = $CenterContainer/VBoxContainer/Name
onready var cost_label = $CenterContainer/VBoxContainer/CostLabel
onready var income_label = $CenterContainer/VBoxContainer/IncomeLabel
onready var upkeep_label = $CenterContainer/VBoxContainer/UpkeepLabel
onready var flavour_label = $CenterContainer/VBoxContainer/FlavourLabel

func _set_structure(slug):
	structure = slug
	name_label.text = str(structure.alias)
	if structure.type == Global.Game.discount_type:
		cost_label.text = "Investment: %s$" % Helper.beautify_number(int(structure.cost * Global.Game.discount))
	else:
		cost_label.text = "Investment: %s$" % Helper.beautify_number(structure.cost)

	upkeep_label.text = "Upkeep: %s$/m" % Helper.beautify_number(structure.building.get_upkeep())
	income_label.text = "Income: %s$/m" % Helper.beautify_number(structure.building.get_income())

	flavour_label.text = str(structure.description)