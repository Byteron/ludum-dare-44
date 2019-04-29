extends Event

export(int) var value = 5000

func _ready():
	description = description % value

func _exectute():
	Global.Game.pay(value)
