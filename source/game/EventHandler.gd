extends Node

signal event_happened(event)

onready var events = $Events

func _ready():
	_setup_events()

func _setup_events():
	for event in events.get_children():
		event.connect("happened", self, "_on_event_happened")

func _on_event_happened(event):
	emit_signal("event_happened", event)