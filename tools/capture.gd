extends Control

# Marketing capture (windowed, NOT --headless). Loads the demo and drives attacks
# while grabbing frames into res://.capture/.

const DEMO := preload("res://demo/combat_demo.tscn")
const OUT := "res://.capture/"

var _frame: int = 0
var _capturing: bool = false
var _demo: Control = null


func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(900, 600))
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUT))
	_demo = DEMO.instantiate()
	add_child(_demo)
	_run()


func _run() -> void:
	_capturing = true
	_capture_loop()

	await _wait(0.8)
	await _shot("start")
	_demo._on_attack_pressed()          # 60 -> 40
	await _wait(0.9)
	_demo._on_attack_pressed()          # 40 -> 20
	await _wait(0.9)
	await _shot("hit")
	_demo._on_attack_pressed()          # 20 -> 0, dies
	await _wait(0.9)
	await _shot("dead")

	_capturing = false
	await _wait(0.2)
	get_tree().quit()


func _capture_loop() -> void:
	while _capturing:
		await RenderingServer.frame_post_draw
		_save(OUT + "gif_%03d.png" % _frame)
		_frame += 1
		await _wait(0.08)


func _shot(shot_name: String) -> void:
	await RenderingServer.frame_post_draw
	_save(OUT + "shot_%s.png" % shot_name)


func _wait(s: float) -> void:
	await get_tree().create_timer(s).timeout


func _save(path: String) -> void:
	var img := get_viewport().get_texture().get_image()
	img.save_png(ProjectSettings.globalize_path(path))
