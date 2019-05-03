extends Event

signal discount_started(type, discount)
signal discount_ended()

export(Building.TYPE) var affected_type = null
export(float, 0.0, 1.0) var discount = 0.3
export(int) var discount_time = 60

onready var discount_timer = $DiscountTimer

func _ready():
	description = description % [ int(discount * 100), discount_time]

func _execute():
	discount_timer.wait_time = discount_time
	discount_timer.start()
	Global.Game.discount = discount
	Global.Game.discount_type = affected_type

func _on_TickTimer_timeout() -> void:
	if Global.Game.discount_type == null:
		._on_TickTimer_timeout()

func _on_DiscountTimer_timeout():
	Global.Game.discount = 1.0
	Global.Game.discount_type = null
