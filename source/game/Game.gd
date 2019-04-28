extends Node2D

const Building = preload("res://source/game/buildings/Building.tscn")
const LivingUnit = preload("res://source/game/buildings/LivingUnit.tscn")
const ProductionUnit = preload("res://source/game/buildings/ProductionUnit.tscn")

var buildings = [
	Building,
	LivingUnit,
	ProductionUnit
]

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
	hud.set_max_budget(budget)
	_setup_buildings()

func build(position):
	var building = buildings[randi() % buildings.size()].instance()
	if building.type == building.TYPE.PRODUCTION_UNIT:
		building.connect("ticked", self, "_on_building_ticked")
	building.position = position
	var new_budget = budget - building.cost
	_set_budget(new_budget)
	add_child(building)

func _setup_buildings():
	for building in building_container.get_children():
		var cell = map.world_to_map(building.position)
		var location = map.get_location(cell)
		building.position = location.position
		location.building = building

func _set_budget(new_budget):
	budget = new_budget
	hud.update_budget(new_budget)

func _on_building_ticked(income):
	_set_budget(budget + income)