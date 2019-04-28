extends PanelContainer

var text setget set_text

func _ready():
	modulate = Color(1, 1, 1, 0)

func set_text(slug):
	text = slug
	$Label.text = text

func fade_in():
	$Tween.interpolate_property(self,"modulate",Color(1, 1, 1, 0),Color.white,0.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	
func fade_out():
	$Tween.interpolate_property(self,"modulate",Color.white,Color(1, 1, 1, 0),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()