extends Control

# Tiny combat demo: the player's Hitbox lands on the enemy's Hurtbox, Health drops,
# the enemy dies. All wiring is nodes + Inspector — this script just drives buttons.

@onready var _hp: ProgressBar = %EnemyHP
@onready var _status: Label = %Status
@onready var _health: HealthLite = %EnemyHealth
@onready var _hurtbox: HurtboxLite = %EnemyHurtbox
@onready var _hitbox: HitboxLite = %PlayerHitbox
@onready var _attack: Button = %Attack


func _ready() -> void:
	_health.damaged.connect(func(a: float, _s: Node): _refresh(); _status.text = "Hit for %d!" % int(a))
	_health.healed.connect(func(a: float): _refresh(); _status.text = "Healed %d" % int(a))
	_health.died.connect(func(): _status.text = "Enemy defeated!"; _attack.disabled = true)
	_refresh()


func _refresh() -> void:
	_hp.max_value = _health.max_health
	_hp.value = _health.current


func _on_attack_pressed() -> void:
	_hitbox._on_area_entered(_hurtbox)


func _on_heal_pressed() -> void:
	_health.heal(15.0)
