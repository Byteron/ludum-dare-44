extends Building

signal ticked(income)

export(int) var revenue = 0
export(int) var upkeep = 0
export(float) var tick_time = 0

onready var tick_timer = $TickTimer

func _ready():
	type = TYPE.PRODUCTION_UNIT

func _calculate_income():
	var income = 0
	for neighbor in neighbors:
		if neighbor.type == TYPE.LIVING_UNIT:
			income += revenue
	return income

func _on_TickTimer_timeout():
	emit_signal("ticked", _calculate_income())

func _on_BuildTimer_timeout():
	._on_BuildTimer_timeout()
	tick_timer.wait_time = tick_time
	tick_timer.start()