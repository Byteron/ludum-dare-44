extends Node

func beautify_number(num):
    var number_string = str(num)
    var index = len(number_string) - 3
    while index > 0:
        number_string = number_string.insert(index, ',')
        index -= 3
    return number_string

func requirements_satisfied(required_buildings):
	var structures = Global.Game.structures
	for alias in required_buildings:
		var structure = structures.get_node(alias)
		if not structure:
			return false
		elif not structure.state == Structure.STATE.BUILT:
			return false
	return true