extends Node

onready var fader = $Fader

func play(sound_name):
	if has_node(sound_name):
		var sound = get_node(sound_name)
		sound.volume_db = linear2db(1.0)
		sound.play()

func fade_out(sound_name):
	if has_node(sound_name):
		var sound = get_node(sound_name)
		fader.interpolate_property(sound,"volume_db",linear2db(1.0),linear2db(0.0),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		fader.start()
