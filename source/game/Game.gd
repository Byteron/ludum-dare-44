extends Node2D

var discount = 1.0
var discount_type = null

export(int) var max_budget = 100000
export(int) var budget = 85000 setget _set_budget

onready var map = $Map
onready var hud = $HUD
onready var event_handler = $EventHandler
onready var building_container = $BuildingContainer

func _unhandled_input(event):
	if event.is_action_pressed("click_left"):
		var mouse_cell = map.world_to_map(get_global_mouse_position())
		var cell_tile = map.get_cellv(mouse_cell)
		var location = map.get_location(mouse_cell)
		if location.building and not location.building.is_build:
			hud.show_investment_popup(location.building)
		elif location.building:
			hud.show_info_popup(location.building)

func _ready():
	Global.Game = self
	hud.set_max_budget(max_budget)
	hud.update_budget(budget)
	_setup_buildings()
	Audio.play("music")
	Audio.play("ambience")

func _build(building):
	var new_budget = 0
	if building.type == discount_type:
		new_budget = budget - int(building.cost * discount)
	else:
		new_budget = budget - building.cost
	_set_budget(new_budget)
	building.build()

func _setup_buildings():
	var buildings = get_tree().get_nodes_in_group("Building")
	for building in buildings:
		building.connect("build", self, "_on_building_build")
		building.connect("mouse_entered", self, "_on_mouse_entered_building")
		building.connect("mouse_exited", self, "_on_mouse_exited_building")

		if building.revenue_tick:
			building.connect("ticked", self, "_on_building_ticked")

		var cell = map.world_to_map(building.position)
		var location = map.get_location(cell)
		building.position = location.position
		location.building = building

func pay(amount):
	var new_budget = budget - amount
	_set_budget(new_budget)

func earn(amount):
	var new_budget = budget - amount
	_set_budget(new_budget)

func _set_budget(new_budget):
	budget = new_budget
	hud.update_budget(new_budget)

func _on_mouse_entered_building(building_name):
	hud.show_name_panel(building_name)

func _on_mouse_exited_building():
	hud.clear_name_panel()

func _on_building_build(building):
	if building.type == Building.TYPE.PUBLISHER:
		event_handler.start_events()

func _on_building_ticked(income):
	_set_budget(budget + income)

func _on_EventHandler_event_happened(event):
	hud.show_article(event)

func _on_HUD_building_invested(building):
	_build(building)

func _on_HUD_hint_purchased():
	_set_budget(budget - Hints.cost_per_hint)