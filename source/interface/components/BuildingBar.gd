extends Control

var time
var hook

onready var tween = $Tween
onready var bar = $TextureProgress

func _ready():
	rect_position = hook.global_position
	tween.interpolate_property(bar, "value", 0, bar.max_value, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_completed")
	queue_free()