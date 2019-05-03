extends Node2D
class_name Building

signal ticked(income, position)

var tick = true

onready var treasurer = $Treasurer

func get_upkeep():
	return treasurer.upkeep

func get_income():
	return treasurer.income

func _on_Treasurer_ticked(income):
	emit_signal("ticked", treasurer.income, position)
