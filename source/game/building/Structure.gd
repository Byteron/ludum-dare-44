extends Node2D

signal building_started(build_time, hook)
signal selected(structure)

signal mouse_entered(building_name)
signal mouse_exited

var cost = 20000
var build_time = 30

var build_requirements = []

export(bool) var build_on_startup = false

onready var lot = $Lot
onready var building = $Building
onready var hover_detector = $HoverDetector

func _unhandled_input(event):
	if event.is_action_pressed("click_left") and hover_detector.hovered:
		emit_signal("selected", self)

func _ready():
	if build_on_startup:
		_on_Lot_building_finished()

func can_build():
	return Helper.requirements_satisfied(build_requirements)

func build():
	lot.build()

func _on_Lot_building_started(build_time, hook):
	emit_signal("building_started", build_time, hook)

func _on_Lot_building_finished():
	building.build()
	lot.queue_free()
	lot = null

func _on_HoverDetector_mouse_entered():
	emit_signal("mouse_entered", building.name)

func _on_HoverDetector_mouse_exited():
	emit_signal("mouse_exited")