extends CanvasLayer

onready var top_panel = $TopPanel

func update_budget(new_budget):
	top_panel.update_budget(new_budget)
