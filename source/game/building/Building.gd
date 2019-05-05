extends Node2D
class_name Building

var tick = true

var customer_radius setget _set_customer_radius
var customer_type setget _set_customer_type

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

func _set_customer_radius(value):
	treasurer.seller_area.radius = value

func _set_customer_type(value):
	treasurer.customer_type = value
