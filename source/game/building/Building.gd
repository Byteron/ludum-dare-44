extends Node2D
class_name Building

signal ticked(income, position)

enum TYPE { BUILDING, RESIDENCE, SELLER, FABRICATOR, SIGHT, PUBLISHER, BANK }

var type

var building_name = "Building"
var flavour_text = "This is a Building"

var tick = true

onready var treasurer = $Treasurer

func _on_Treasurer_ticked(income):
	emit_signal("ticked", treasurer.income, position)
