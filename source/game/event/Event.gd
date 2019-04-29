extends Node
class_name Event

signal happened(event)
export(bool) var one_time_event = false
export(int) var tick_time = 10
export(float, 0.0, 1.0) var probability = 0.1

export(String) var title = "Event Title"
export(String) var button_text = "Hmnn..."
export(String, MULTILINE) var description = "An event happened this week!"

export(Array, String) var required_unbuild = []
export(Array, String) var required_build = []

onready var tick_timer = $TickTimer

func _ready():
	tick_timer.one_shot = one_time_event
	tick_timer.wait_time = tick_time

func start_tick_timer():
	tick_timer.start()

func _build_requirements_satisfied():
	var buildings = Global.Game.building_container
	for building_name in required_build:
		var building = buildings.get_node(building_name)
		if not building.is_build:
			print(building_name, " is not build")
			return false
	return true

func _unbuild_requirements_satisfied():
	var buildings = Global.Game.building_container
	for building_name in required_unbuild:
		var building = buildings.get_node(building_name)
		if building.is_build:
			print(building_name, " is build")
			return false
	return true

func _execute():
	print("OVERWRITE")

func _on_TickTimer_timeout() -> void:
	randomize()
	print(name, ": Build: ", required_build, " - ", _build_requirements_satisfied())
	print(name, ": Unbuild: ", required_unbuild, " - ", _unbuild_requirements_satisfied())
	if randf() < probability and _build_requirements_satisfied() and _unbuild_requirements_satisfied():
		emit_signal("happened", self)