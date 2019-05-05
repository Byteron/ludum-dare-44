extends Node2D
class_name Structure

enum STATE { UNBUILT, BUILDING, BUILT }
enum TYPE { BUILDING, RESIDENCE, SELLER, FABRICATOR, SIGHT, PUBLISHER, BANK }

signal building_started(build_time, hook)
signal building_finished(building)

signal selected(structure)

signal mouse_entered(building_name)
signal mouse_exited

var cost = 0
var build_time = 0

var alias = "Building"
var description = "This is a Building"

var state = STATE.UNBUILT
var type = TYPE.BUILDING

var tick = false

export(bool) var build_on_startup = false

export(Resource) var res = null

export(Array, String) var build_requirements = []
export(Array, String) var bonus_requirements = []
export(Array, String) var malus_requirements = []

onready var lot = $Lot
onready var building = $Building
onready var hover_detector = $HoverDetector
onready var collision_shape = $CollisionShape2D

func _unhandled_input(event):
	if event.is_action_pressed("click_left") and hover_detector.hovered:
		emit_signal("selected", self)

func _ready():
	collision_shape.shape = collision_shape.shape.duplicate(true)
	building.visible = false
	_initialize()
	if build_on_startup:
		_on_Lot_building_finished()

func can_build():
	return Helper.requirements_satisfied(build_requirements)

func build():
	lot.build()

func _initialize():

	if not res:
		print("Warning: No resource defined for ", name)
		return

	cost = res.cost
	type = res.type
	tick = res.tick
	description = res.description
	building.tick = res.tick
	building.treasurer.customers = res.customers
	building.customer_type = res.customer_type
	building.treasurer.upkeep = res.upkeep
	building.treasurer.revenue = res.revenue
	building.treasurer.bonus = res.bonus
	building.treasurer.malus = res.malus
	building.treasurer.bonus_requirements = bonus_requirements
	building.treasurer.malus_requirements = malus_requirements
	building.sprite.texture = res.building_texture
	building.customer_radius = res.customer_radius
	lot.build_time = res.build_time
	hover_detector.size = res.building_texture.region.size

func _on_Lot_building_started(build_time, hook):
	state = STATE.BUILDING
	emit_signal("building_started", build_time, hook)

func _on_Lot_building_finished():
	state = STATE.BUILT
	building.call_deferred("build", tick)
	lot.queue_free()
	lot = null
	emit_signal("building_finished", self)

func _on_HoverDetector_mouse_entered():
	emit_signal("mouse_entered", building.name)

func _on_HoverDetector_mouse_exited():
	emit_signal("mouse_exited")