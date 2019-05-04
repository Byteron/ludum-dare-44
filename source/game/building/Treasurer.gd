extends Node
class_name Treasurer

const TICK_TIME = 10

signal ticked

var revenue = 0
var upkeep = 0

var penalty = 0
var boost = 0

var bonus_requirements = []
var malus_requirements = []

var income setget ,_calculate_income

onready var timer = Timer.new()

func ready():
	timer.wait_time = TICK_TIME
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)

func start():
	timer.start()

func _calculate_income():
	var income = revenue - upkeep
	if not Helper.requirements_satisfied(malus_requirements):
		income -= penalty
	elif Helper.requirements_satisfied(bonus_requirements):
		income += boost
	return income

func _on_timer_timeout():
	emit_signal("ticked", _calculate_income())
	Audio.play("cash")