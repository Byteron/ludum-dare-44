extends Node2D
class_name Building

signal ticked(income, position)

var tick = true

onready var treasurer = $Treasurer
onready var sprite = $Sprite
onready var hook = $InterfaceHook

func build(tick):
	if tick:
		treasurer.start()
	visible = true

func get_upkeep():
	return treasurer.upkeep

func get_income():
	return treasurer.income

func _on_Treasurer_ticked(income):
	print(name, " ticked")
	emit_signal("ticked", treasurer.income, hook.global_position)
