extends Node2D

signal building_started(build_time, hook)
signal building_finished

var build_time

onready var timer = $Timer
onready var sprite = $Sprite
onready var hook = $InterfaceHook

func _ready():
	pass # _randomize_sprite()

func build():
	timer.wait_time = build_time
	timer.start()
	emit_signal("building_started", build_time, hook)

func _randomize_sprite():
	randomize()
	sprite.texture = sprite.texture.duplicate(true)
	sprite.texture.region.position.x += (randi() % 3) * 16

func _on_Timer_timeout():
	Audio.play("built")
	emit_signal("building_finished")