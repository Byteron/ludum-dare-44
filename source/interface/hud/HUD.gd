extends CanvasLayer

signal building_invested(building)
signal hint_purchased

onready var top_panel = $TopPanel
onready var building_popup = $BuildingPopup
onready var newspaper = $Newspaper
onready var name_panel = $NamePanel

func _ready():
	newspaper.show()

func show_article(text):
	newspaper.show_article(text)
	name_panel.text = ""
	name_panel.fade_out()

func show_building_popup(building):
	building_popup.building = building
	building_popup.popup()

func set_max_budget(max_budget):
	top_panel.set_max_budget(max_budget)

func update_budget(new_budget):
	top_panel.update_budget(new_budget)

func show_name_panel(building_name):
	name_panel.text = building_name
	name_panel.fade_in()

func clear_name_panel():
	name_panel.text = ""
	name_panel.fade_out()

func _on_BuildingPopup_invested(building):
	emit_signal("building_invested", building)


func _on_TopPanel_hint_purchased():
	emit_signal("hint_purchased")
	var next_hint = Hints.get_next_hint()
	$Letter.show_article(next_hint)