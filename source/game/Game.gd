extends Node2D

const Building = preload("res://source/game/buildings/Building.tscn")

func _input(event):
	if event.is_action_pressed("click_left"):
		var mouse_position = get_global_mouse_position()
		var building = Building.instance()
		building.position = mouse_position
		add_child(building)