extends Control

export(String) var text = ""
export(Color) var tint = Color("FFFFFFFF")

export(Vector2) var final_scale = Vector2(1.5, 1.5)
export(float) var float_distance = 100
export(float) var duration = 0.25

onready var tween = $Tween
onready var label = $Label

func _ready():
	label.text = text
	modulate = tint

	tween.interpolate_property(self, "rect_scale", rect_scale, final_scale, duration, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_completed")

	var transparent = Color(modulate.r, modulate.g, modulate.b, 0.0)

	tween.interpolate_property(self, "rect_position", rect_position, rect_position + Vector2(0, -float_distance), duration, Tween.TRANS_BACK, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", modulate, transparent, duration, Tween.TRANS_BACK, Tween.EASE_IN)
	tween.start()

	yield(tween, "tween_completed")

	queue_free()