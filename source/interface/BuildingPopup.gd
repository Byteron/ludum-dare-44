extends PopupPanel

var building setget _set_building

onready var name_label = $VBoxContainer/Name
onready var cost_label = $VBoxContainer/CostLabel
onready var revenue_label = $VBoxContainer/RevenueLabel
onready var upkeep_label = $VBoxContainer/UpkeepLabel
onready var flavour_label = $VBoxContainer/FlavourLabel

func _set_building(slug):
	building = slug
	name_label.text = str(building.building_name)
	cost_label.text = "Investment: %s$" % str(building.cost)

	if building.type == building.TYPE.LIVING_UNIT:
		revenue_label.text = "Max Revenue: %s$" % "-"
		upkeep_label.text = "Upkeep: %s$" % "-"

	elif building.type == building.TYPE.PRODUCTION_UNIT:
		revenue_label.text = "Max Revenue: %d$" % building.revenue
		upkeep_label.text = "Upkeep: %d$" % building.upkeep

	flavour_label.text = str(building.flavour_text)

func _on_InvestButton_pressed():
	building.build()
	building = null
	hide()