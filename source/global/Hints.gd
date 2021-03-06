extends Node

#6 lines a 12 chars max per hint
var cost_per_hint = 1000

var queue
var hint_list = [
	"Click on buildings or building sights to view or invest.",
	"Lumbercamps are a honest business. I can't see what could go wrong.",
	"Supermarkets need nearby residents to make profit. This should be obvious.",
	"Some investments may be a bad idea... I can't tell, that's your job.",
	"Cafés may not make us rich, but they are a safe investment.",
	"Tourism can bring in lots of revenue.. if you meet the tourists needs!",
	"Who cares for the cost of a space program, the neighbours will admire us!",
	"Research has found no logical reasons to build a church.",
	"I have caught the bee in your bureau as you requested me to.",
	"Can we build a fire station? I love the sound of their sirens.",
	"Building a statue will provide prestige and might attract tourists.",
	"Hospitals generate no income, why were they even invented!",
	"I'm afraid that's all I can tell you.. Do your best!"
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