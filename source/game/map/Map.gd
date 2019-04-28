extends TileMap

var size = Vector2()

var locations = {}

func _ready():
	size = get_used_rect().size
	_load_locations()

func map_to_world_centered(cell):
	return map_to_world(cell) + cell_size / 2

func get_location(cell):
	return locations[_flatten(cell)]

func _load_locations():
	for y in size.y:
		for x in size.x:
			var cell = Vector2(x, y)
			var location = Location.new()

			location.cell = cell
			location.position = map_to_world_centered(cell)
			location.building = null
			locations[_flatten(cell)] = location

func _flatten(cell):
	return int(cell.y) * int(size.x) + int(cell.x)