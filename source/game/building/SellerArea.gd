extends Area2D

var size setget _set_size

onready var collision_shape = $CollisionShape2D

func _ready():
	collision_shape.shape = collision_shape.shape.duplicate(true)

func _set_size(value):
	collision_shape.shape.extents.x = value.x
	collision_shape.shape.extents.y = value.y

func get_residence_count_in_area():
	var count = 0
	var areas = get_overlapping_areas()

	for area in areas:

		if not area is Structure:
			continue

		if not area.state == Structure.STATE.BUILT:
			continue

		if area.type == Structure.TYPE.RESIDENCE:
			count += 1
	return count