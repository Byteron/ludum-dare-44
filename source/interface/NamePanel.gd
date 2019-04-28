extends PanelContainer

var text setget set_text

func set_text(slug):
	text = slug
	$Label.text = text