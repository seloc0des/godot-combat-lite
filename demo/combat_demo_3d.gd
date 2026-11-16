extends Node3D

# Lite 3D demo: walk up to the dummy and hit it. Everything is nodes + Inspector; this
# script only moves the player and swings the sword. Keyboard only: WASD to move,
# Space to hit.

const SPEED := 5.0
const SWING_TIME := 0.15

@onready var _player: CharacterBody3D = %Player
@onready var _sword: HitboxLite3D = %Sword
@onready var _health: HealthLite = %DummyHealth
@onready var _status: Label = %Status

var _swing_left := 0.0


func _ready() -> void:
	_sword.monitoring = false
	_health.damaged.connect(func(a: float, _s: Node) -> void: _status.text = "Hit for %d! %d left." % [int(a), int(_health.current)])
	_health.died.connect(_on_dummy_defeated)


# The dummy tips over so the defeat is visible, then stands back up for another go.
func _on_dummy_defeated() -> void:
	_status.text = "Dummy defeated!"
	var mesh: Node3D = get_node("Dummy/Mesh")
	var tip := create_tween()
	tip.tween_property(mesh, "rotation_degrees:x", 90.0, 0.25)
	tip.parallel().tween_property(mesh, "position:y", 0.4, 0.25)
	tip.tween_interval(2.0)
	tip.tween_callback(func() -> void:
		_health.revive()
		_status.text = "Dummy is back. Hit it again.")
	tip.tween_property(mesh, "rotation_degrees:x", 0.0, 0.25)
	tip.parallel().tween_property(mesh, "position:y", 0.9, 0.25)


func _physics_process(delta: float) -> void:
	var dir := Vector3(
		float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A)),
		0.0,
		float(Input.is_key_pressed(KEY_S)) - float(Input.is_key_pressed(KEY_W)))
	if dir != Vector3.ZERO:
		dir = dir.normalized()
		# the body turns to face where it walks, so the sword in front of it swings round with it
		_player.rotation.y = lerp_angle(_player.rotation.y, atan2(-dir.x, -dir.z), 12.0 * delta)
	_player.velocity.x = dir.x * SPEED
	_player.velocity.z = dir.z * SPEED
	if not _player.is_on_floor():
		_player.velocity.y -= 24.0 * delta
	_player.move_and_slide()
	if _swing_left > 0.0:
		_swing_left -= delta
		if _swing_left <= 0.0:
			_sword.monitoring = false
	elif Input.is_key_pressed(KEY_SPACE) and _health.is_alive():
		_swing_left = SWING_TIME
		_sword.monitoring = true
