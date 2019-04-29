extends Building

func _init():
	type = TYPE.LIVING_UNIT

func _ready():
	_randomize_building_texture()

func _randomize_building_texture():
	randomize()
	building_texture = building_texture.duplicate(true)
	building_texture.region.position.x += (randi() % 5) * 16