# Combat (Lite)

Free no-code combat core for **Godot 4.5+**, in 2D and in 3D. A Health component and team-gated
Hitbox / Hurtbox areas, wired through a global hit bus. Drop the nodes in, set
damage in the Inspector. No code to make things take damage and die.

Part of the **SELODEV** system line. This is the free core, with a **Combat** dock
that bakes Health, Hurtbox and Hitbox onto a node. **Combat (Pro)** adds damage
types & crits, resistances, knockback, invincibility frames, respawn,
hitstop, projectiles, and dock buttons for health bars, game over on death and
kill reports.

## 5-minute setup

1. Copy `addons/combat_lite/` into your project.
2. Enable **Combat (Lite)** in Project Settings → Plugins (adds the `CombatLite`
   bus autoload and the **Combat** chooser dock).
3. Select your enemy node → in the **Combat** dock set Max health, leave **Side**
   on **Enemy side**, click **Add Health + Hurtbox** (it adds a CollisionShape2D
   too). Leave **Remove it when it dies** ticked and a beaten enemy disappears.
   Each hit that hurts it flashes it white (Health's **Flash On Hit**, on by default).
4. Select your weapon/projectile → set Damage, leave its **Side** on
   **Player side (hurts enemies)**, click **Add Hitbox**. The two defaults
   already hurt each other.

To do it by hand, add **HealthLite** + **HurtboxLite** (Area2D + shape) to
the target and a **HitboxLite** (Area2D + shape) to the attacker. The result is the same.

For a 3D game: in a 3D scene (a scene whose top node is a Node3D) the same two
buttons build the 3D nodes. **Add Health + Hurtbox** adds a `HurtboxLite3D` with a
box shape, and **Add Hitbox** adds a `HitboxLite3D`. By hand, use **HurtboxLite3D**
and **HitboxLite3D** (Area3D + CollisionShape3D). The Health node is the same in 2D and 3D. If your scene's top node is a plain Node,
the node you select decides: a Node3D gets the 3D nodes.

When the hitbox overlaps a different-team hurtbox, Health takes the damage and the
`CombatLite.hit_landed` bus fires. Connect your VFX/audio there.

## The pieces

| Node | Role |
|---|---|
| `HealthLite` | `take_damage()` / `heal()` / `revive()`; signals `damaged`, `healed`, `died`; `is_alive()`, `fraction()`; `remove_on_death` (the dock's tick); `flash_on_hit` / `flash_color` (on by default) |
| `HurtboxLite` (Area2D) | "can be hit"; finds its sibling Health; `team` gates friendly fire |
| `HitboxLite` (Area2D) | "deals damage"; `damage`, `team`, `one_shot` |
| `HurtboxLite3D` (Area3D) | the 3D twin of `HurtboxLite`. The bus gets a Vector3 position |
| `HitboxLite3D` (Area3D) | the 3D twin of `HitboxLite`, with the same fields |
| `CombatLite` (autoload) | global `hit_landed(position, amount, source)` (the position is a Vector2 from a 2D hurtbox and a Vector3 from a 3D one) + `entity_died(entity)` |

## Reacting to hits (e.g. VFX)

```gdscript
CombatLite.hit_landed.connect(func(pos, amount, source):
    spawn_hit_spark(pos))          # e.g. one of the SELODEV Hit VFX packs
```

## Verify

```bash
godot --headless --path . res://tools/verify.tscn   # prints PASS
```
Or open `tools/acceptance.tscn` in the editor and press Play for a PASS/FAIL banner.

## License

MIT. Use it in commercial games.


## Part of a family

This is one free tier from the selodev catalog of no-code Godot 4 systems. They share an item contract and a save contract, so they plug into each other, and each one also works fully on its own.

Free systems:

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite)
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite)
- [Loot Lite](https://github.com/seloc0des/godot-loot-lite)
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite)
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite)
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite)
- [Stats / Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite)
- [Save / Load Lite](https://github.com/seloc0des/godot-save-load-lite)
- [Dialogue Lite](https://github.com/seloc0des/godot-dialogue-lite)
- [Combat Lite](https://github.com/seloc0des/godot-combat-lite)
- [Controller Lite](https://github.com/seloc0des/godot-controller-lite)
- [Enemy AI Lite](https://github.com/seloc0des/godot-enemy-ai-lite)
- [Scene Flow Lite](https://github.com/seloc0des/godot-scene-flow-lite)
- [Audio Lite](https://github.com/seloc0des/godot-audio-lite)
- [Level Builder Lite](https://github.com/seloc0des/godot-level-builder-lite)
- [Weather System Lite](https://github.com/seloc0des/godot-weather-lite)
- [Settings + Menus](https://github.com/seloc0des/godot-settings-menus) (complete and free, no paid tier)

Free VFX: [Magic Cast](https://github.com/seloc0des/godot-magic-cast-vfx-lite), [Elemental Impact](https://github.com/seloc0des/godot-elemental-impact-vfx-lite), [Explosion](https://github.com/seloc0des/godot-explosion-vfx-lite), [Pickup, Buff & Heal](https://github.com/seloc0des/godot-pickup-buff-vfx-lite).

Free starter projects: [Free Starter](https://github.com/seloc0des/free-starter-godot), [Dungeon](https://github.com/seloc0des/godot-dungeon-starter), [Survival](https://github.com/seloc0des/godot-survival-starter), [RPG](https://github.com/seloc0des/godot-rpg-starter).

The [full versions](https://selodev.itch.io/combat-no-code-combat-system-for-godot-4) add drop-in UI, editor docks and the cross-system wiring. They're on itch.io: **https://selodev.itch.io**
