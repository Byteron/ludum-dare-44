extends CanvasLayer

signal scene_loading_done

# Scenes
const TitleScreen := "res://source/interface/menu/TitleScreen.tscn"
const Game := "res://source/game/Game.tscn"

var next_scene := ""
var loader: ResourceInteractiveLoader = null

onready var anim := $AnimationPlayer as AnimationPlayer
onready var fps_label := $FPS as Label
onready var loading_bar := $LoadProgress as TextureProgress

func _process(delta):
	fps_label.text = "%d FPS" % Engine.get_frames_per_second()

	if loader == null:
		return

	match loader.poll():
		OK:
			loading_bar.value = loader.get_stage()
		ERR_FILE_EOF:
			emit_signal("scene_loading_done")

func change(scene: String) -> void:
	next_scene = scene
	anim.play("fade_out")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		loader = ResourceLoader.load_interactive(next_scene)
		loading_bar.max_value = loader.get_stage_count() - 1

		yield(self, "scene_loading_done")

		if not get_tree().change_scene_to(loader.get_resource()) == OK:
			print("Global: failed to load ", next_scene)

		anim.play("fade_in")
		next_scene = ""
		loader = null

func _on_LoadProgress_value_changed(value: float) -> void:
	if loading_bar.max_value == value:
		loading_bar.visible = false
	elif loading_bar.visible == false:
		loading_bar.visible = true
