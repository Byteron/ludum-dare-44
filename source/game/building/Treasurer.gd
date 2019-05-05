extends Node2D
class_name Treasurer

const FRACT = 7.0 / 30.0

signal ticked(income, position)

var revenue = 0
var upkeep = 0

var bonus = 0
var malus = 0

var bonus_requirements = []
var malus_requirements = []

var income setget ,_calculate_income

var customers = false
var customer_type setget _set_customer_type

onready var seller_area = $SellerArea

func start():
	Global.Game.tick_timer.connect("timeout", self, "_on_Timer_timeout")

func _calculate_income():
	var income = 0
	var count = seller_area.get_residence_count_in_area()
	if customers:
		income = revenue * count - upkeep
	else:
		income = revenue - upkeep
	if not Helper.requirements_satisfied(malus_requirements):
		income -= malus
	elif Helper.requirements_satisfied(bonus_requirements):
		income += bonus
	return income

func _set_customer_type(value):
	seller_area.customer_type = value

func _on_Timer_timeout():
	emit_signal("ticked", int(_calculate_income() * FRACT), global_position)
	Audio.play("cash")