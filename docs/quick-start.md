# Quick Start: Combat (Lite)

Goal: an enemy that takes damage and dies, in about 5 minutes, with no code.

## 1. Install

- Copy `addons/combat_lite/` into your project.
- Enable **Combat (Lite)** in Project Settings → Plugins (adds the `CombatLite` bus
  and the **Combat** dock).

## 2. Make an enemy that can be hurt

In the **Combat** dock: select the enemy, leave **Side** on **Enemy side**, click
**Add Health + Hurtbox**. It adds both nodes plus a CollisionShape2D. Click again
to retune them. Leave **Remove it when it dies** ticked and the enemy disappears
when its health runs out. It starts unticked when you select your player.

Every hit that hurts a character flashes it white for a moment, so you can see hits
land. That's **Flash On Hit** on its HealthLite, on by default, with **Flash Color**
beside it. The killing hit doesn't flash. Untick it if your character has its own
hit effect.

Or by hand, on your enemy scene:
- Add a **HealthLite** node. Set `max_health` (e.g. 60).
- Add a **HurtboxLite** (Area2D) with a **CollisionShape2D** covering the body.
  Set its `team` (e.g. 1). It auto-finds the HealthLite sibling.

## 3. Make something that deals damage

In the **Combat** dock: select the weapon swing, projectile or spike, leave its
**Side** on **Player side (hurts enemies)**, click **Add Hitbox**.

Or by hand, on your weapon swing / projectile / spike:
- Add a **HitboxLite** (Area2D) with a **CollisionShape2D**.
- Set `damage` (e.g. 20) and a **different** `team` (e.g. 0).
- Tick `one_shot` for projectiles that should hit once.

When the hitbox overlaps the hurtbox, Health drops. At 0 it emits `died`, and an
enemy made with **Remove it when it dies** ticked is taken out of the game right
after. By hand, that's the `remove_on_death` box on the HealthLite.

On an enemy made with the Enemy AI pack (Pro or Lite), **Add Hitbox** also sets
how close its Brain walks up (its attack radius), so the hitbox reaches the
player's hurtbox, and has the Brain switch the hitbox on for every attack, so
the enemy hurts the player once per attack cooldown while they stay in reach.
The status line says what it set. If you resize either box later, click
**Add Hitbox** on the enemy again.

## 4. React to hits (optional)

```gdscript
func _ready():
    $Enemy/HealthLite.died.connect($DeathSound.play)    # a sound when it dies
    CombatLite.hit_landed.connect(func(pos, amt, src):  # global hit feedback
        $HitSound.play())
```

## Teams

Same `team` never damages each other (no friendly fire). Give the player team 0,
enemies team 1; an enemy attack uses a hitbox on team 1 so it hits the player
(team 0) but not other enemies.

The **Combat** dock does this for you with its two **Side** picks: Health +
Hurtbox defaults to **Enemy side** (team 1) and the Hitbox to
**Player side (hurts enemies)** (team 0), so a fight made with the defaults
works as it is.

## Next

- Health API (`heal`, `revive`, `fraction` for health bars) → README.
- Damage types, crits, resistances, knockback, i-frames, respawn, projectiles,
  hitstop, and dock buttons for health bars, game over on death and kill reports
  come with **Combat (Pro)**.
