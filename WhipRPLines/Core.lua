-- WhipRPLines engine: /rpline <moment>. Edit Lines.lua for the text.
-- Fires only from a slash command (a macro button press), never from events,
-- so SAY works and nothing is sent automatically.

local _, ns = ...
local moments = ns.moments or {}

local PREFIX = "|cff9482c9RPLines:|r "
local function note(msg)
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. msg)
end

-- Random pick that never returns the same entry twice in a row per list.
local lastPick = {}
local function pick(list)
    if not list or #list == 0 then return nil end
    if #list == 1 then return list[1] end
    local i
    repeat i = math.random(#list) until i ~= lastPick[list]
    lastPick[list] = i
    return list[i]
end

-- Use the global SendChatMessage: it is proven to work in-game on Forever.
-- Switching to C_ChatInfo.SendChatMessage (the wiki's modern replacement)
-- broke emotes, so it is only a fallback in case a patch removes the global.
local SendChatApi = SendChatMessage or (C_ChatInfo and C_ChatInfo.SendChatMessage)
local API_NAME = SendChatMessage and "SendChatMessage" or "C_ChatInfo.SendChatMessage"

-- /rpline debug toggles this: report every send and what the API returned.
local debugMode = false

-- `target` is only used for WHISPER (the player's name, with realm if needed).
local function SendChat(text, channel, target)
    local result = SendChatApi(text, channel, nil, target)
    if debugMode then
        note("debug: " .. channel .. (target and (" to " .. target) or "") .. " via " .. API_NAME .. " -> " .. tostring(result) .. " | " .. text:sub(1, 40))
    end
end

local function inGroup()
    if IsInGroup then return IsInGroup() end
    return (GetNumPartyMembers and GetNumPartyMembers() > 0)
        or (GetNumRaidMembers and GetNumRaidMembers() > 0)
end

local function send(text, channel)
    if (channel == "PARTY" or channel == "RAID") and not inGroup() then
        note("(preview, not grouped) " .. text)
        return
    end
    SendChat(text, channel)
end

-- Works out who the moment is about.
-- Returns "none" (moment has no unit), "self", or "other" plus the name.
-- Returns nil if nothing should be sent.
local function resolve(m)
    if not m.unit then return "none" end
    local unit = m.unit
    if not UnitExists(unit) or UnitIsUnit(unit, "player") then
        if m.selfLines or m.selfEmotes then return "self" end
        note("no " .. unit .. " -- nothing sent.")
        return nil
    end
    if not (UnitIsPlayer(unit) and UnitIsFriend("player", unit)) then
        note(unit .. " is not a friendly player -- nothing sent.")
        return nil
    end
    return "other", UnitName(unit)
end

local function fill(text, name)
    if text and name then return format(text, name) end
    return text
end

local function run(key)
    local m = moments[key]
    if not m then
        note("unknown moment '" .. key .. "'. Type /rpline for the list.")
        return
    end
    if m.chance and math.random() > m.chance then return end

    local who, name = resolve(m)
    if not who then return end
    if debugMode then
        note("debug: " .. key .. " -> " .. who .. (name and (" (" .. name .. ")") or "") .. ", speak=" .. tostring(m.speak ~= false))
    end

    local emote, line
    if who == "self" then
        emote = pick(m.selfEmotes)
        line = pick(m.selfLines)
    else
        emote = fill(pick(m.emotes), name)
        line = fill(pick(m.lines), name)
    end

    if emote then SendChat(emote, "EMOTE") end
    local speaks = m.speak ~= false and (not m.speakChance or math.random() <= m.speakChance)
    if line and speaks then
        send(line, m.channel or "SAY")
        -- whisper = true: the same line also goes to the named player, so
        -- someone far away (a summon) reads what the people nearby hear.
        if m.whisper and who == "other" then
            local to = (GetUnitName and GetUnitName(m.unit, true)) or name
            SendChat(line, "WHISPER", to)
        end
    end
end

local function listMoments()
    local keys = {}
    for k in pairs(moments) do keys[#keys + 1] = k end
    table.sort(keys)
    note("usage: /rpline <moment>. Moments: " .. table.concat(keys, ", "))
end

-- Load-time check: catch text with the wrong number of %s, or text that
-- would exceed the 255-character chat limit, before it misbehaves.
-- (A filled-in name is at most 12 characters.)
local MAX_CHAT = 255
local NAME_ROOM = 12
local function countS(s)
    local _, n = s:gsub("%%s", "")
    return n
end
local function check(key, field, list, want)
    for _, s in ipairs(list or {}) do
        if countS(s) ~= want then
            note(key .. "." .. field .. " needs " .. want .. " %s: " .. s)
        end
        local len = #s + want * NAME_ROOM
        if len > MAX_CHAT then
            note(key .. "." .. field .. " too long for chat (" .. len .. "/255): " .. s:sub(1, 40) .. "...")
        end
    end
end
for key, m in pairs(moments) do
    local want = m.unit and 1 or 0
    check(key, "lines", m.lines, want)
    check(key, "emotes", m.emotes, want)
    check(key, "selfLines", m.selfLines, 0)
    check(key, "selfEmotes", m.selfEmotes, 0)
end

SLASH_WHIPRPLINES1 = "/rpline"
SlashCmdList.WHIPRPLINES = function(msg)
    local key = (msg or ""):match("^%s*(%S*)"):lower()
    if key == "" then
        listMoments()
    elseif key == "debug" then
        debugMode = not debugMode
        note("debug " .. (debugMode and "on" or "off") .. " (sending via " .. API_NAME .. ")")
    else
        run(key)
    end
end
