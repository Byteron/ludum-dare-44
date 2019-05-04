extends Node2D
class_name Treasurer

const FRACT = 7.0 / 30.0

signal ticked(income, position)

var revenue = 0
var upkeep = 0

var penalty = 0
var boost = 0

var bonus_requirements = []
var malus_requirements = []

var income setget ,_calculate_income

onready var seller_area = $SellerArea

func start():
	Global.Game.tick_timer.connect("timeout", self, "_on_Timer_timeout")

func _calculate_income():
	var count = seller_area.get_residence_count_in_area()
	var income = revenue * count - upkeep
	if not Helper.requirements_satisfied(malus_requirements):
		income -= penalty
	elif Helper.requirements_satisfied(bonus_requirements):
		income += boost
	return income

func _on_Timer_timeout():
	emit_signal("ticked", int(_calculate_income() * FRACT), global_position)
	Audio.play("cash")