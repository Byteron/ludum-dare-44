extends Node2D

const Building = preload("res://source/game/buildings/Building.tscn")
const LivingUnit = preload("res://source/game/buildings/LivingUnit.tscn")
const ProductionUnit = preload("res://source/game/buildings/ProductionUnit.tscn")

var buildings = [
	LivingUnit,
	ProductionUnit
]

export(int) var max_budget = 10000
export(int) var budget = 1000 setget _set_budget

onready var map = $Map
onready var building_container = $BuildingContainer
onready var hud = $HUD

func _input(event):
	if event.is_action_pressed("click_left"):
		var mouse_cell = map.world_to_map(get_global_mouse_position())
		var cell_tile = map.get_cellv(mouse_cell)
		var tile_name = map.tile_set.tile_get_name(cell_tile)

		if tile_name == "ground":
			var location = map.get_location(mouse_cell)
			if location.building and not location.building.is_build:
				hud.show_building_popup(location.building)

func _ready():
	hud.set_max_budget(max_budget)
	hud.update_budget(budget)
	_setup_buildings()

func _build(building):
	var new_budget = budget - building.cost
	_set_budget(new_budget)
	building.build()

func _setup_buildings():
	for building in building_container.get_children():
		building.connect("mouse_entered", self, "_on_mouse_entered_building")
		building.connect("mouse_exited", self, "_on_mouse_exited_building")

		if building.type == building.TYPE.PRODUCTION_UNIT:
			building.connect("ticked", self, "_on_building_ticked")

		var cell = map.world_to_map(building.position)
		var location = map.get_location(cell)
		building.position = location.position
		location.building = building

func _set_budget(new_budget):
	budget = new_budget
	hud.update_budget(new_budget)

func _on_mouse_entered_building(building_name):
	hud.show_name_panel(building_name)

func _on_mouse_exited_building():
	hud.clear_name_panel()

func _on_building_ticked(income):
	_set_budget(budget + income)

func _on_EventHandler_event_happened(event):
	hud.show_article(event.description)

func _on_HUD_building_invested(building):
	_build(building)
