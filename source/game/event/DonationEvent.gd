extends Event

export(int) var value = 5000

func _ready():
	description = description % value

func _execute():
	Global.Game.earn(value)