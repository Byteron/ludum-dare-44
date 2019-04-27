extends Node2D
class_name Building

enum TYPE { LIVING_UNIT, PRODUCTION_UNIT }

var type = null
var neighbors = []

export(Texture) var building_texture = null
export(int) var build_time = 4.0

onready var tween = $Tween
onready var build_timer = $BuildTimer
onready var sprite = $Sprite
onready var building_progress = $BuildingProgress

func _ready():
	build_timer.wait_time = build_time
	build_timer.start()

	tween.interpolate_property(building_progress, "value", 0, building_progress.max_value, build_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _on_BuildTimer_timeout():
	building_progress.hide()

	tween.interpolate_property(sprite, "modulate", Color("000000"), Color("FFFFFF"), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()

	sprite.texture = building_texture
