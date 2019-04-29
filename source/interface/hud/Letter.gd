extends Control

var slide_distance
var visible_pos
var hidden_pos

func _ready():
	visible_pos = rect_position
	hidden_pos = rect_position
	slide_distance = - rect_size.y * 2 + 10
	hidden_pos.y += slide_distance
	rect_position = hidden_pos

func show_article(text):
	$Label.text = text
	slide_in()

func slide_in():
	$Tween.interpolate_property(self, "rect_position", hidden_pos, visible_pos, 0.8, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.start()
	Audio.play("click")

func slide_out():
	$Tween.interpolate_property(self, "rect_position", visible_pos, hidden_pos, 0.8, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()

func _on_Button_pressed():
	if not $Tween.is_active():
		slide_out()
