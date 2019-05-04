extends Label

var days = 0

func _on_Timer_timeout():

	days += 1

	var temp = 0
	var year = int(days / 365) + 2012
	temp = days % 360
	var month = int(temp / 30) + 1
	temp = days % 30
	var day = days % 30 + 1

	text = "%d.%d.%d" % [ day, month, year ]