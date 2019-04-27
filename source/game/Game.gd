extends Node2D

const Building = preload("res://source/game/buildings/Building.tscn")

export(int) var budget = 1000 setget _set_budget

onready var hud = $HUD

func _input(event):
	if event.is_action_pressed("click_left"):
		var mouse_position = get_global_mouse_position()
		build(mouse_position)

func build(position):
	var building = Building.instance()
	building.position = position
	var new_budget = budget - building.cost
	_set_budget(new_budget)
	add_child(building)

func _set_budget(new_budget):
	budget = new_budget
	hud.update_budget(new_budget)