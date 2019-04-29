extends Control

var slide_distance
var visible_pos
var hidden_pos

var event = null

onready var accept_timer = $AcceptTimer
onready var button = $VBoxContainer/Button

onready var title_label = $VBoxContainer/VBoxContainer/Title
onready var description_label = $VBoxContainer/VBoxContainer/Description

func _ready():
	visible = true
	visible_pos = rect_position
	hidden_pos = rect_position
	slide_distance = - rect_size.y * 2 + 10
	hidden_pos.y += slide_distance
	rect_position = hidden_pos

func show_article(event):
	if self.event:
		button.emit_signal("pressed")
	self.event = event
	accept_timer.start()
	button.text = event.button_text
	title_label.text = event.title
	description_label.text = event.description
	slide_in()

func slide_in():
	$Tween.interpolate_property(self, "rect_position", hidden_pos, visible_pos, 0.8, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.start()
	Audio.play("alert")

func slide_out():
	$Tween.interpolate_property(self, "rect_position", visible_pos, hidden_pos, 0.8, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()

func _on_Button_pressed():
	if not $Tween.is_active():
		event._execute()
		accept_timer.stop()
		slide_out()
		if event.one_time_event:
			event.queue_free()
			event = null

func _on_AcceptTimer_timeout():
	button.emit_signal("pressed")
