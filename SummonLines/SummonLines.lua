-- Summon Lines: random Warlock flavor text for Ritual of Summoning.
-- Usage in a macro:
--   #showtooltip Ritual of Summoning
--   /summonline
--   /cast Ritual of Summoning
--
-- Add as many lines as you like below.
-- Emotes: third person, no pronouns, end with a period.
-- Lines: must contain exactly one %s (the summoned player's name).

local emotes = {
    "traces a burning sigil in the air.",
    "shudders, fel light burning behind the eyes.",
    "draws the Nether close, shadows coiling at the feet.",
    "laughs softly as the air begins to tear.",
    "presses a hand to the ground. It blackens.",
}

local lines = {
    "The veil tears for %s. Its burn is a gift.",
    "I feel the Nether in my veins. %s, come through.",
    "Power demands pain. I pay it gladly. Rise, %s.",
    "The void bends to my will. Step through, %s.",
    "%s, the Nether hungers. Come before it feeds.",
    "Fel fire burns a path for %s.",
    "Every soul has a price. %s's is paid.",
    "The shadows whisper your name, %s. I answer.",
    "Bound by shadow, dragged by will: %s.",
}

-- Set to "PARTY" to keep it within your group instead of saying it aloud.
local CHANNEL = "SAY"
-- Set to false to skip the emote and only speak the line.
local USE_EMOTE = true

SLASH_SUMMONLINE1 = "/summonline"
SlashCmdList.SUMMONLINE = function()
    local name = UnitName("target") or "someone"
    if USE_EMOTE then
        SendChatMessage(emotes[math.random(#emotes)], "EMOTE")
    end
    SendChatMessage(format(lines[math.random(#lines)], name), CHANNEL)
end
