extends Event

export(Array, String, MULTILINE) var variants = []

func _execute():
	if variants:
		description = variants[randi() % variants.size()]