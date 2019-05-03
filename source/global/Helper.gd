extends Node

func beautify_number(num):
    var number_string = str(num)
    var index = len(number_string) - 3
    while index > 0:
        number_string = number_string.insert(index, ',')
        index -= 3
    return number_string

func requirements_satisfied(required_buildings):
	var buildings = Global.Game.building_container
	for building_name in required_buildings:
		var building = get_node(building_name)
		if not building:
			return false
		elif not building.built:
			return false
	return true