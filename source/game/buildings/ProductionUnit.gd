extends Building

const PopLabel = preload("res://source/interface/PopLabel.tscn")

signal ticked(income)

export(int) var revenue = 20
export(int) var upkeep = 10
export(float) var tick_time = 10

onready var tick_timer = $TickTimer

func _init():
	type = TYPE.PRODUCTION_UNIT

func _calculate_income():
	var income = 0
	for neighbor in neighbours:
		if neighbor.type == TYPE.LIVING_UNIT:
			income += revenue
	return income - upkeep

func _on_TickTimer_timeout():
	var income = _calculate_income()
	emit_signal("ticked", income)
	var label = PopLabel.instance()
	label.text = str(income)
	if income < 0:
		label.tint = Color("FF0000")
	else:
		label.tint = Color("00FF00")
	add_child(label)

func _on_BuildTimer_timeout():
	._on_BuildTimer_timeout()
	tick_timer.wait_time = tick_time
	tick_timer.start()