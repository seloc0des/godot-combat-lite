extends Node

# Test stand-in for the full Enemy AI brain. The Combat dock spots one by the
# exports both tiers share, and a full one by attack_node_path, so this needs no
# Enemy AI pack.

@export var detect_radius: float = 160.0
@export var attack_radius: float = 40.0
@export var target_group: StringName = &"player"
@export var attack_cooldown: float = 1.0
@export var attack_duration: float = 0.25
@export var attack_node_path: NodePath
