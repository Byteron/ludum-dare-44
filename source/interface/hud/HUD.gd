extends CanvasLayer

onready var top_panel = $TopPanel

func set_max_budget(max_budget):
	top_panel.set_max_budget(max_budget)

func update_budget(new_budget):
	top_panel.update_budget(new_budget)
