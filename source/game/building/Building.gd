extends Node2D
class_name Building

var tick = true

var seller_area setget _set_seller_area

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

func _set_seller_area(size):
	treasurer.seller_area.size = size
