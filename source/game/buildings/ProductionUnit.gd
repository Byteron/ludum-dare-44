extends Building

const PopLabel = preload("res://source/interface/PopLabel.tscn")

signal ticked(income)

export(int) var revenue = 20
export(int) var upkeep = 10
export(float) var tick_time = 10

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
	emit_signal("ticked", revenue) # should be _calculate_income, not revenue, only for demo
	var label = PopLabel.instance()
	label.text = str(revenue)
	label.tint = Color("00FF00")
	add_child(label)

func _on_BuildTimer_timeout():
	._on_BuildTimer_timeout()
	tick_timer.wait_time = tick_time
	tick_timer.start()