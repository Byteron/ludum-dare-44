extends Area2D

var hovered = false
var size setget _set_size

onready var collision_shape = $CollisionShape2D

func _ready():
	collision_shape.shape = collision_shape.shape.duplicate(true)

func _set_size(value):
	collision_shape.shape.extents.x = int(value.x / 2) - 3
	collision_shape.shape.extents.y = int(value.y / 2) - 3

func _on_HoverDetector_mouse_entered():
	hovered = true

func _on_HoverDetector_mouse_exited():
	hovered = false