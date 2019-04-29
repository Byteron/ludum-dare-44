extends Node
class_name Event

signal happened(event)

export(int) var tick_time = 10
export(float, 0.0, 1.0) var probability = 0.1

export(String) var title = "Event Title"
export(String, MULTILINE) var description = "An event happened this week!"

onready var tick_timer = $TickTimer

func _ready():
	tick_timer.wait_time = tick_time
	tick_timer.start()

func _execute():
	print("OVERWRITE")

func _on_TickTimer_timeout() -> void:
	randomize()
	if randf() < probability:
		emit_signal("happened", self)