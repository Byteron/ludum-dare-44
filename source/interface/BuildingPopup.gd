extends PopupPanel

signal invest_pressed

var building setget set_building

var cost_string = "Investment: %s$"
var income_string = "Max Income: %s$"
var upkeep_string = "Upkeep: %s$"

func set_building(slug):
	building = slug
	$VBoxContainer/Name.text = Helper.beautify_number(building.building_name)
	$VBoxContainer/CostLabel.text = cost_string  % Helper.beautify_number(building.cost)
	$VBoxContainer/IncomeLabel.text = income_string % Helper.beautify_number(building.income)
	$VBoxContainer/UpkeepLabel.text = upkeep_string % Helper.beautify_number(building.upkep)
	$VBoxContainer/FlavourLabel.text = Helper.beautify_number(building.flavourtext)

func _on_InvestButton_pressed():
	emit_signal("invest_pressed")
	

func _on_BuildingPopup_about_to_show():
	$VBoxContainer/InvestButton.disabled = building.cost > get_node("/root/Game").budget