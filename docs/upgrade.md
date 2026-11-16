# Upgrading to Combat (Pro)

Combat (Lite) is the free core: Health, team-gated Hitbox/Hurtbox, and a hit bus.
When you outgrow it, **Combat (Pro)** adds the parts that get fiddly to hand-roll.

| | Lite (free) | Pro |
|---|---|---|
| Health + take_damage/heal | ✅ | ✅ |
| Team-gated Hitbox/Hurtbox | ✅ | ✅ |
| Global hit bus | ✅ | ✅ |
| No-code chooser dock | ✅ | ✅ |
| Damage types & weaknesses | — | ✅ |
| Critical hits | — | ✅ |
| Resistances / armor / defense | — | ✅ |
| Knockback | — | ✅ |
| Invincibility frames | — | ✅ |
| Hitstop / screen shake hooks | — | ✅ |
| Projectile helper | — | ✅ |
| Remove a beaten enemy (dock tick) | ✅ | ✅ |
| Respawn after a delay | — | ✅ |
| Stats/Skills integration | — | ✅ |
| Dock buttons: health bars, game over on death, kill reports | — | ✅ |

The full version installs next to the Lite, in its own folder, so you can move over one piece at a time. It isn't a drop-in replacement: `HealthLite`, `HitboxLite` and `HurtboxLite` become `CombatHealth`, `CombatHitbox` and `CombatHurtbox`. `heal`, `is_alive` and `fraction` keep their names. `take_damage`, `revive` and `receive_hit` don't exist in the full version, so code that calls them needs rewriting, and the Lite nodes in your scenes need swapping for the full ones.

Get it on itch.io. Use it in any game you make, commercial or not.
