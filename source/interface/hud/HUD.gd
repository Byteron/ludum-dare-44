extends CanvasLayer

onready var top_panel = $TopPanel
onready var building_popup = $BuildingPopup

func show_building_popup(building):
	building_popup.building = building
	building_popup.popup()

func set_max_budget(max_budget):
	top_panel.set_max_budget(max_budget)

func update_budget(new_budget):
	top_panel.update_budget(new_budget)