extends Node2D
class_name Building

const PopLabel = preload("res://source/interface/PopLabel.tscn")

signal ticked(income)

signal mouse_entered(building_name)
signal mouse_exited

enum TYPE { LIVING_UNIT, SELLING_UNIT, PRODUCTION_UNIT, DECORATION_UNIT }

var type = TYPE.DECORATION_UNIT
var neighbours = []

var is_build = false

export(String) var building_name = "Building Name"
export(String) var flavour_text = ""


export(bool) var build_on_startup = false
export(bool) var revenue_tick = false
export(bool) var revenue_per_housing = true

export(int) var cost = 10000
export(int) var build_time = 4.0

export(int) var revenue = 20
export(int) var upkeep = 10
export(float) var tick_time = 10

export(Array, String) var required_buildings = []
export(Texture) var building_texture = null

onready var tick_timer = $TickTimer

onready var tween = $Tween
onready var build_timer = $BuildTimer
onready var sprite = $Sprite
onready var building_progress = $BuildingProgress

func _ready():
	build_timer.wait_time = build_time
	if build_on_startup:
		is_build = true
		call_deferred("_on_BuildTimer_timeout")

func can_build():
	for building_name in required_buildings:
		if not Global.Game.building_container.has_node(building_name):
			return false
	return true

func build():
	is_build = true
	building_progress.show()
	build_timer.start()

	tween.interpolate_property(building_progress, "value", 0, building_progress.max_value, build_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _calculate_income():
	var income = 0
	if revenue_per_housing:
		for neighbor in neighbours:
			if neighbor.type == TYPE.LIVING_UNIT:
				income += revenue
	else:
		income = revenue
	return income - upkeep

func _on_TickTimer_timeout():
	var income = _calculate_income()
	emit_signal("ticked", income)
	var label = PopLabel.instance()
	label.text = "+" + str(income) + "$"
	if income < 0:
		label.tint = Color("FF0000")
	else:
		label.tint = Color("00FF00")
	add_child(label)
	Audio.play("cash")

func _on_BuildTimer_timeout():
	building_progress.hide()
	Audio.play("build")
	tween.interpolate_property(sprite, "modulate", Color("000000"), Color("FFFFFF"), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()

	sprite.texture = building_texture

	if revenue_tick:
		tick_timer.wait_time = tick_time
		tick_timer.start()

func _on_MouseArea_mouse_entered():
	emit_signal("mouse_entered", building_name)

func _on_MouseArea_mouse_exited():
	emit_signal("mouse_exited")
