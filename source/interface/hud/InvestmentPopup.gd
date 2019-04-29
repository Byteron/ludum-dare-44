extends BuildingPopup

signal invested(building)

onready var invest_button = $CenterContainer/VBoxContainer/InvestButton

func _on_InvestmentPopup_about_to_show():
	invest_button.disabled = building.cost > Global.Game.budget

func _on_InvestButton_pressed():
	Audio.play("confirm")
	emit_signal("invested", building)
	building = null
	hide()
