extends PopupPanel

signal invest_pressed

var building setget set_building

func set_building(slug):
	building = slug
	$VBoxContainer/Name.text = str(building.building_name)
	$VBoxContainer/CostLabel.text = str(building.cost)
	$VBoxContainer/IncomeLabel.text = str(building.income)
	$VBoxContainer/UpkeepLabel.text = str(building.upkep)
	$VBoxContainer/FlavourLabel.text = str(building.flavourtext)

func _on_InvestButton_pressed():
	emit_signal("invest_pressed")
	