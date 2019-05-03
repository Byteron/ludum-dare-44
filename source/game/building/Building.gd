extends Node2D
class_name Building

signal ticked(income, position)
signal built(building_name)

signal mouse_entered(building_name)
signal mouse_exited

enum TYPE { BUILDING, RESIDENCE, SELLER, FABRICATOR, SIGHT, PUBLISHER, BANK }

var type

var neighbours = []

var building_name = "Building"
var flavour_text = "This is a Building"

var tick = true
var revenue_per_housing = true

var cost = 15000
var build_time = 10

var penalty = 0
var boost = 0
var revenue = 0
var upkeep = 0
var tick_time = 10

var penalty_requirements = []
var boost_requirements = []
var building_texture = null

var built = false
var building = false
var hovered = false

export(bool) var build_on_startup = false

onready var tick_timer = $TickTimer

onready var tween = $Tween
onready var build_timer = $BuildTimer
onready var sprite = $Sprite
onready var building_progress = $BuildingProgress

func _unhandled_input(event):
	pass

func _ready():
	_randomize_lot()
	build_timer.wait_time = build_time
	if build_on_startup:
		built = true
		call_deferred("_on_BuildTimer_timeout")

func penalty_requirements_satisfied():
	var buildings = Global.Game.building_container
	for building_name in penalty_requirements:
		if not buildings.has_node(building_name):
			return false
		if not buildings.get_node(building_name).built:
			return false
	return true

func boost_requirements_satisfied():
	var buildings = Global.Game.building_container
	for building_name in boost_requirements:
		if not buildings.has_node(building_name):
			return false
		if not buildings.get_node(building_name).built:
			return false
	return true

func build():
	building = true
	building_progress.show()
	build_timer.start()

	tween.interpolate_property(building_progress, "value", 0, building_progress.max_value, build_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _randomize_lot():
	randomize()
	sprite.texture = sprite.texture.duplicate(true)
	sprite.texture.region.position.x += (randi() % 3) * 16

func _calculate_income():
	var income = 0
	if revenue_per_housing:
		for neighbor in neighbours:
			if neighbor.type == TYPE.LIVING_UNIT:
				income += revenue
	else:
		income = revenue

	income -= upkeep

	if not penalty_requirements_satisfied():
		income -= penalty

	elif boost_requirements_satisfied():
		income += boost

	return income

func per_minute(value):
	return int(value * (60 / tick_time))

func income_per_minute():
	return per_minute(_calculate_income())

func upkeep_per_minute():
	return per_minute(upkeep)

func revenue_per_minute():
	if revenue_per_housing:
		return per_minute(revenue * 8)
	return per_minute(revenue)

func _on_TickTimer_timeout():
	var income = _calculate_income()
	print("ticked", position)
	emit_signal("ticked", income, position)
	Audio.play("cash")

func _on_BuildTimer_timeout():
	building = false
	built = true
	building_progress.hide()
	Audio.play("built")
	tween.interpolate_property(sprite, "modulate", Color("000000"), Color("FFFFFF"), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()

	sprite.texture = building_texture

	if tick:
		tick_timer.wait_time = tick_time
		tick_timer.start()

	emit_signal("built", self)

func _on_MouseArea_mouse_entered():
	hovered = true
	emit_signal("mouse_entered", building_name)

func _on_MouseArea_mouse_exited():
	hovered = false
	emit_signal("mouse_exited")
