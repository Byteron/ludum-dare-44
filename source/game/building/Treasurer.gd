extends Node2D
class_name Treasurer

const TICK_TIME = 10

signal ticked(income, position)

var revenue = 0
var upkeep = 0

var penalty = 0
var boost = 0

var bonus_requirements = []
var malus_requirements = []

var income setget ,_calculate_income

onready var timer = $Timer
onready var seller_area = $SellerArea

func _ready():
	timer.wait_time = TICK_TIME

func start():
	timer.start()

func _calculate_income():
	var count = seller_area.get_residence_count_in_area()
	var income = revenue * count - upkeep
	if not Helper.requirements_satisfied(malus_requirements):
		income -= penalty
	elif Helper.requirements_satisfied(bonus_requirements):
		income += boost
	return income

func _on_Timer_timeout():
	emit_signal("ticked", _calculate_income(), global_position)
	Audio.play("cash")