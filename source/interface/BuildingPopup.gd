extends PopupPanel

signal invest_pressed

var building setget set_building

var cost_string = "Investment: %s$"
var income_string = "Max Income: %s$"
var upkeep_string = "Upkeep: %s$"

func set_building(slug):
	building = slug
	$VBoxContainer/Name.text = str(building.building_name)
	$VBoxContainer/CostLabel.text = cost_string % str(building.cost)
	$VBoxContainer/IncomeLabel.text = income_string % str(building.income)
	$VBoxContainer/UpkeepLabel.text = upkeep_string % str(building.upkep)
	$VBoxContainer/FlavourLabel.text = str(building.flavourtext)

func _on_InvestButton_pressed():
	emit_signal("invest_pressed")
	