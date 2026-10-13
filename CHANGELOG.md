# Changelog: Combat (Lite)

## 1.3.2 (2026-10-12)

The tabs show their names on Godot 4.5.

- **The Combat tab was blank on Godot 4.5.** Its tab beside the Inspector had no title, so "open the
  Combat tab" pointed at nothing. It is named when the pack switches on now. Godot 4.7 was not
  affected.

## 1.3.1 (2026-09-28)

- **The hit flash is white.** It was a red tint, and a tint only shows on a sprite that has that
  colour in it: a green or teal enemy just went dark for a moment. White shows on any sprite.
  **Flash Color** still takes any colour you like.

## 1.3.0 (2026-09-28)

Hits show on screen.

- **A character flashes when a hit hurts it.** The first hits on an enemy used to show nothing at
  all until it died, so it looked like nothing was happening. Health has a new **Flash On Hit** tick,
  on by default, and a **Flash Color**. The killing hit doesn't flash. It works on 2D characters.
  Untick it if your character already has a hit effect of its own.

## 1.2.1 (2026-09-27)

Installs without errors, and its tab works the moment you switch it on.

- **Its tab works the moment you switch it on.** Right after installing, Add Health + Hurtbox
  added the Health but not the Hurtbox, and the status line went blank, until you restarted Godot.
- **No red errors when you install it.** Installing it filled the Output panel with "Failed to
  load script" errors before you'd even switched it on. Some of its scripts named a part of the
  pack that only exists once the pack is on.
- **The Combat tab fits and scrolls.** On smaller screens or at a bigger editor scale the tab was
  wider and taller than its panel: the status line sat below the screen and the dropdown arrows were
  cut off at the right edge. It now scrolls, headings and long button labels wrap, and a side choice
  only ends in "…" when the panel is narrower than its name.

## 1.2.0 (2026-09-27)

A beaten enemy disappears, with no code.

- **Add Health + Hurtbox has a "Remove it when it dies" tick, and it starts ticked.** When that
  character's health runs out, it's taken out of the game. Before, it stayed standing unless you
  wrote code to remove it.
- **Everything listening for the death still hears it first**, so a score counter or your own
  scripts get the death before the character goes.
- **The tick starts unticked for your player**, and a note under it says why: a player that
  vanished when it died would leave nothing on screen. It does the same for anything that's part
  of your player, or that has your player inside it. You can still tick it yourself.
- **Clicking Add Health + Hurtbox again changes the tick on the Health that's already there**,
  instead of adding a second Health.
- **The same setting is a Remove On Death box on HealthLite in the Inspector.** Health added
  before this version keeps the box off, so your scenes behave as they did.
- The bundled PASS/FAIL banner scene now also exits cleanly when run headless.

## 1.1.0 (2026-09-26)

- **Add Hitbox on an enemy with an Enemy AI brain fits the brain's attack radius** so the hitbox
  reaches the player past both bodies, and says so. If it can't reach, the status says to make the
  hitbox bigger.
- **Each button picks a side, and the defaults hit.** The shared Team number is replaced by a
  **Side** pick per button: Health + Hurtbox starts on the enemy side, Hitbox on the player's, so a
  hit lands with no fields changed. Scenes you already built behave as before.
- **Clicking a button again retunes what's there** (max health, damage, side) instead of stacking a
  second Health, Hurtbox or Hitbox, and the new values reach Play.
- **Nodes the dock adds don't run their game code in the editor**, and pressing Play right after a
  button includes what it added.
- The README and quick start name the Lite's own Combat dock. They used to call it Pro-only.
- **Nodes the Setup tab adds get readable names.** A second one under the same parent is
  called something like `UILayer2`, instead of a generated name full of `@` signs.
- **Switching the plugin off only removes the autoload if the plugin added it**, and closing
  the editor no longer removes it at all. A project that declares it itself, like the starter
  kits, keeps it.
- **The Combat tab no longer cuts its text off.** It opened in a narrow column, so labels, file
  pickers and the notes at the bottom ran past the edge. It now asks for the same width as the
  other tabs.

## 1.0.2 — 2026-08-10

A quieter first run. No change to how anything behaves.

- **The debugger no longer fills with warnings when you press Play.** The event bus declares the signals every system talks through, and Godot flagged each one as unused because the code that sends and receives them lives in the other files. Nothing was broken, but a first run could print a stack of warnings that looked like your mistakes. They're gone.

## 1.0.1 — 2026-08-10

Safer download.

- **The download can't damage a project you're already working on.** It now unzips into one folder named after the pack, instead of putting files loose at the top. Before this, unzipping it straight into an existing game overwrote that game's name, its start-up scene and the list of add-ons you had switched on. It can't reach any of that now.
- **Added START-HERE.txt and INSTALLING.txt** at the top of the folder — what's in the download, the two-minute install, and what to do if something goes wrong. Plain text, opens anywhere.
- **Fixed: the docs pointed at a self-test file that wasn't there.** They said `tools/verify.tscn`; in the download it's `tools/combat_lite/verify.tscn`. The paths now match what's actually in the box.

## 1.0.0

- Initial release.
- `HealthLite` component: take_damage / heal / revive, is_alive / fraction, signals (damaged, healed, died).
- `HurtboxLite` / `HitboxLite` (Area2D): team-gated damage, auto-wired health, one_shot option.
- `CombatLite` autoload bus: hit_landed(position, amount, source), entity_died(entity).
- No-code chooser dock: bake Health+Hurtbox / Hitbox onto the selected node.
- Demo: attack-a-goblin health bar scene.
- Headless `tools/verify.tscn` (8 checks) + `tools/acceptance.tscn` PASS/FAIL banner.
