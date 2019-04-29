extends TileMap

var map_rect = Vector2()

var locations = {}

func _ready():
	map_rect = get_used_rect()

	_load_locations()
	call_deferred("_update_neighbours")

func map_to_world_centered(cell):
	return map_to_world(cell) + cell_size / 2

func get_location(cell):
	var id = _flatten(cell)
	if locations.has(id):
		return locations[id]
	return null

func get_neighbour_buildings(cell):
	var neighbour_buildings = []
	for n_cell in get_neighbour_cells(cell):
		var n_loc = get_location(n_cell)
		if not n_loc:
			continue
		if not n_loc.building:
			continue
		if not n_loc.building.is_build:
			continue
		neighbour_buildings.append(n_loc.building)
	return neighbour_buildings

func get_neighbour_cells(cell):
	return [
		Vector2(cell.x, cell.y + 1),
		Vector2(cell.x, cell.y - 1),
		Vector2(cell.x + 1, cell.y + 1),
		Vector2(cell.x + 1, cell.y),
		Vector2(cell.x + 1, cell.y - 1),
		Vector2(cell.x - 1, cell.y + 1),
		Vector2(cell.x - 1, cell.y),
		Vector2(cell.x - 1, cell.y - 1)]

func _update_neighbours():
	for loc in locations.values():
		if not loc.building or not loc.building.is_build:
			continue
		var neighbours = get_neighbour_buildings(loc.cell)
		loc.building.neighbours = neighbours

func _load_locations():
	for y in range(map_rect.position.y, map_rect.position.y + map_rect.size.y):
		for x in range(map_rect.position.x, map_rect.position.x + map_rect.size.x):
			var cell = Vector2(x, y)
			var location = Location.new()

			location.cell = cell
			location.position = map_to_world_centered(cell)
			location.building = null
			locations[_flatten(cell)] = location

func _flatten(cell):
	return int(cell.y) * int(map_rect.size.x) + int(cell.x)

func _on_NeighbourTimer_timeout():
	_update_neighbours()
