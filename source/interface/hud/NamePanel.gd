extends PanelContainer

var text setget _set_text

onready var tween = $Tween
onready var label = $CenterContainer/Label

func _ready():
	modulate = Color(1, 1, 1, 0)

func _set_text(slug):
	text = slug
	label.text = text

func fade_in():
	tween.stop_all()
	tween.remove_all()

	tween.interpolate_property(self,"modulate",Color(1, 1, 1, 0),Color.white,0.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()

func fade_out():
	tween.stop_all()
	tween.remove_all()

	tween.interpolate_property(self,"modulate",Color.white,Color(1, 1, 1, 0),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()