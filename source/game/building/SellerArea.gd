extends Area2D

var radius setget _set_radius
var customer_type

onready var collision_shape = $CollisionShape2D


func _ready():
	collision_shape.shape = collision_shape.shape.duplicate(true)

func _set_radius(value):
	radius = value
	collision_shape.shape.radius = value

func get_residence_count_in_area():
	var count = 0
	var areas = get_overlapping_areas()

	for area in areas:

		if not area is Structure:
			continue

		if not area.state == Structure.STATE.BUILT:
			continue

		if area.type == customer_type:
			count += 1
	return count