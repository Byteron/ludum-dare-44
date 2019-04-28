extends Node

func beautify_number(num):
    var number_string = str(num)
    var index = len(number_string) - 3
    while index > 0:
        number_string = number_string.insert(index, ',')
        index -= 3
    return "$" + number_string