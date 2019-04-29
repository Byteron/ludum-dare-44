extends Node

#6 lines a 12 chars max per hint
var cost_per_hint = 1000

var queue
var hint_list = [
	"Supermarkets need nearby residents to make profit. This should be obvious.",
	"Some investments may be a bad idea... I can't tell, that's your job."
	]
	
func _ready():
	queue = hint_list.duplicate()

func get_next_hint():
		
	var next_hint = queue[0]
	queue.pop_front()
	
	if queue.size() == 0:
		queue = hint_list.duplicate()
		cost_per_hint = 0
		
	return(next_hint)