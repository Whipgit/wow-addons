# WoW Forever AddOns -- Working Notes

This repository holds my own addons for **World of Warcraft: Forever**: role-play emotes and chat lines, small quality-of-life tools for my characters. We write and edit them here; the game loads them through junctions (see "Repo layout").

## Environment

- **Game:** World of Warcraft: Forever (launched Nov 2026). Vanilla 1.x content and talent spine on a modern engine. Client build 1.60.x.
- **Game install:** `C:\Program Files (x86)\World of Warcraft\_forever_`. Live addons folder: `...\_forever_\Interface\AddOns`.
- **TOC interface number:** `## Interface: 16001`. Confirm in-game with `/dump select(4, GetBuildInfo())` and update this line if it changes after a patch. "Load out of date AddOns" is ticked anyway, but keep our addons on the current number.
- **Lua:** WoW's embedded Lua 5.1. No `require`, no external libraries unless vendored into the addon folder.
- **API reference:** https://warcraft.wiki.gg/wiki/World_of_Warcraft_API. Forever runs on a modern client, so many modern APIs (including `C_` namespaces) exist, but some Classic/retail functions may be missing or behave differently. Forever is newer than Claude's training data, so **verify an API exists for this client before relying on it.** When unsure, add a guard (`if C_Something and C_Something.Func then ... end`) and tell me to test it.
- **Claude cannot run the game.** Every change is untested until I check it in-game. Say so plainly rather than implying something works.
- **Reloading:** after edits I run `/reload` in-game. Lua errors: `/console scriptErrors 1`, or BugSack/BugGrabber if installed.

## Repo layout

- Each addon is a top-level folder in this repo (`SummonLines/`, ...) containing a `.toc` whose filename matches the folder name exactly.
- `link-addons.ps1` creates a directory junction in the game's `Interface\AddOns` for every addon folder here, so edits in the repo are live after `/reload`. Run it once after adding a new addon. Junctions need no admin rights, but writing into `Program Files (x86)` might; if it fails, run PowerShell as administrator once.
- New addon checklist: create the folder and `.toc`, run `link-addons.ps1`, then restart the game client (a brand-new addon folder is only picked up at client start, not on `/reload`).
- Repo-only files (this file, scripts, README) stay at the root; the game ignores anything without a `.toc`.

## Hard rules

1. **Never edit third-party addons** in the game's AddOns folder (Forever_Thanks, Macro Toolkit, Auctionator, Pawn, the Spoken packs, etc.) unless I explicitly ask. Updates overwrite those edits anyway. Build our own addon here instead.
2. **Our addons get distinctive folder names** so they never collide with downloaded ones.
3. **Don't touch the `WTF` folder** (SavedVariables, settings) without asking, and never while the game is running -- the client overwrites it on logout and changes get lost.
4. **Respect Blizzard's restrictions.** Don't try to work around them:
   - Protected functions (casting, targeting, movement such as `ToggleAutoRun`) can't be called from addon code; they only work from macros/keybinds via secure templates.
   - `SendChatMessage` to `SAY`/`YELL` in the open world requires a hardware event (a key press). Fine from a slash command fired by a macro button; blocked if fired automatically from an event handler. `PARTY`, `RAID`, `WHISPER`, `EMOTE` are fine.
   - Some clients allow only one restricted chat message per key press. An emote plus one `SAY` line is safe; two restricted lines (`SAY` + `YELL`) per press may drop the second. If a feature sends two, test that both arrive.
   - Macros are hard-capped at 255 characters. Macro Toolkit's "extended macros" no longer work. Long logic belongs in an addon exposed as a slash command; the macro just calls `/command` and `/cast`.
5. **No automation that plays the game for me** (botting, auto-casting, auto-targeting). Flavor, reminders, UI, information, and one-button conveniences only.

## Conventions

- Small and readable over clever. One `.lua` file per addon until it genuinely needs more.
- Put user-editable content (text lines, toggles) in clearly labelled tables at the **top** of the file, with a comment explaining the format.
- Slash commands: `SLASH_NAME1 = "/command"` + `SlashCmdList.NAME = function(msg) ... end`.
- Persist settings via the `.toc` only when needed, with defaults applied on `ADDON_LOADED`. Default to `## SavedVariablesPerCharacter` (my characters have different voices); use account-wide `## SavedVariables` only for settings that are truly global.
- Chat flavor lines use `%s` for the target's name; one `%s` per line.
- After writing or changing an addon, give me: the macro to use (if any), what to `/reload` (or whether a client restart is needed), and what to check in-game.

## Our addons

| Folder | Status | What it does | Usage |
|---|---|---|---|
| `SummonLines` | Built, untested in-game. Run `link-addons.ps1`, then restart the client. | Random Warlock emote + spoken line when summoning. Lists at top of `SummonLines.lua`; `CHANNEL` and `USE_EMOTE` toggles. | Macro: `#showtooltip Ritual of Summoning` / `/summonline` / `/cast Ritual of Summoning` |

Keep this table updated when we add or change addons.

## Open decision: one RP addon or many

Planned next: Soulstone, Healthstone, Cannibalize (Forsaken racial), demon summons, Shaman lines for Aelith. They all share the same mechanics: pick a random line, fill in `%s`, send to a channel, optional emote, fired from a macro. Two ways to build that:

- **One addon per moment** (`SummonLines`, `SoulstoneLines`, ...): matches the one-file convention, but copies the same engine into every folder.
- **One RP addon with a table per moment** and a slash command per moment (`/rpline summon`, `/rpline soulstone`): one engine, one place for toggles, lines grouped by character. Probably the better fit, but it becomes the one addon that "genuinely needs more" than one file (engine + a lines file).

Decide this with me before building the second one.

## My characters (Horde)

- **Warlock** -- Forsaken, Affliction (drain-tanking while leveling; Destruction dual spec planned), Herbalism + Alchemy. My most-played character; my friends group with it. Uses Succubus/Voidwalker, focus/mouseover macros for Fear and Seduction.
- **Kestra** -- Hunter, early levels.
- **Aelith Gales** -- Skyborne (Windshaper) Shaman, female, early levels. Little sister of a friend's Shaman, Entressa Gales.
- **Mage** -- parked around level 10, Tailoring.

Warlock flavor: dark, Chaos-tinged, the Nether as something that hungers, pain as power. Original lines only -- don't copy quotes from other games or media.

## Ideas backlog

- Same flavor-line pattern for other Warlock moments: Soulstone, Healthstone handoff, Fear on a dangerous add, demon summons.
- Cannibalize lines for the Warlock (Forsaken racial).
- Shaman flavor lines with a wind/elemental voice for Aelith.
- A small reminders or tracker addon (soul shards, buffs, profession cooldowns) -- scope with me first, and check how shards work on Forever before designing around them.

## How I like to work

- I'm a software engineering director; talk to me as a peer and push back when an idea is a bad fit for the client or the API.
- Prose over bullet spam in explanations. Double hyphens (--), not em dashes.
- Ask before large or multi-file changes; small edits to our own addons can just go ahead.
- Commit and push only when I ask.
