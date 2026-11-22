-- WhipRPLines: the lines. This is the file to edit; Core.lua is the engine.
--
-- Each entry in `moments` below is one /rpline command. The key is the
-- command word: moments.soulstone is fired by "/rpline soulstone".
--
-- The emote is what tells bystanders what you are doing, so every emote
-- names the action plainly ("summons a Voidwalker", "places a Soulstone on
-- %s") before adding flavor. The spoken line is pure character voice.
--
-- Fields (all optional except that a moment needs lines or emotes):
--   emotes      Third-person emotes, no pronouns for you, end with a period.
--               Sent as /emote before the spoken line.
--   lines       Spoken lines, one picked at random.
--               If `unit` is set: emotes and lines must each contain exactly
--               one %s (filled with that unit's name).
--               If `unit` is not set: no %s at all.
--   selfEmotes  Used instead of `emotes` / `lines` when `unit` is you or
--   selfLines   doesn't exist (e.g. a Soulstone on yourself). No %s.
--               Leave both out to send nothing when you have no valid target.
--   unit        Whose name fills %s: "target" (or "focus", "mouseover").
--               Leave out for moments without a name (demon summons).
--   channel     Where the spoken line goes: "SAY" (default), "PARTY",
--               "YELL", "EMOTE". PARTY when not grouped only previews the
--               line in your own chat window.
--   chance      0 to 1. Chance the moment fires at all (1 = always, default).
--               Lower it for things you cast often. The spell is still cast.
--
-- Nothing repeats twice in a row.

local _, ns = ...

ns.moments = {

    -- ===================== WARLOCK =====================

    -- Ritual of Summoning. Target the player you are summoning.
    summon = {
        unit = "target",
        emotes = {
            "begins a Ritual of Summoning for %s. A burning sigil tears open in the air, and the Nether leaks through.",
            "raises hands steaming with fel light and opens a summoning portal to bring %s here.",
            "starts the Ritual of Summoning, reaching through the Nether to drag %s across the distance.",
            "calls on the Nether to summon %s. The ground beneath the portal blackens and smokes.",
            "tears a summoning rift in the air for %s and laughs softly as it widens.",
        },
        lines = {
            "I am reaching through the Nether for %s, and something on the other side is reaching back.",
            "Come through, %s. Do not look at what passes you in the dark. It will be looking at you.",
            "The road from there to here runs through the Nether, %s. I will drag you along it quickly. Try not to scream.",
            "I have torn a hole in the world for you, %s. It bleeds fel light and it is hungry. Step through before it closes on you.",
            "Distance is a mortal problem, %s. I simply fold the dark and pull you across it.",
            "I can feel you on the other side, %s, small and warm. The things in the Nether can feel you too. Hurry.",
            "Every mile between us, %s, I pay for in pain. It is a good pain. Come.",
            "The portal is open, %s. Some of what lives between worlds will try to follow you out. Leave that to me.",
            "%s, I have your soul by a thread and the Nether by the throat. Come through before either one slips.",
            "Click the portal and lend me your strength. I am pulling %s through the dark, and the dark does not let go easily.",
            "Come, %s. I crossed the grave once and came back. Crossing the Nether is nothing. For me, at least.",
            "I call, %s, and the Nether carries you. It will want a toll for the ride. I have already paid it in blood.",
        },
    },

    -- Soulstone Resurrection. Target someone, or no one / yourself for a
    -- self-stone.
    soulstone = {
        unit = "target",
        emotes = {
            "closes dead fingers around a Soulstone and binds a piece of %s's soul inside. Violet light bleeds between them.",
            "places a Soulstone on %s. Should death come, the stone will drag them back.",
            "crushes a soul shard and anchors %s's soul to a Soulstone, beyond death's reach.",
            "presses a Soulstone to %s's chest. Somewhere beyond the veil, a hundred hungry things turn to look.",
            "murmurs in a tongue that makes the shadows lean closer, sealing %s's soul into a Soulstone.",
            "shudders as fel fire crawls down the warlock's arm into a Soulstone and binds %s's soul to it.",
        },
        lines = {
            "I have carved a piece of your soul loose, %s, and locked it in the stone. It screams in there. I find the sound comforting.",
            "The Nether pressed against me while I bound you, %s. It wanted all of you. I let it taste me instead. A fair price.",
            "Your soul is in the stone, %s. If you fall, I will drag you back through the dark myself. Do not ask what the passage costs.",
            "Hold still, %s. I am reaching into you. It burns, I know. Pain is how the Nether knows the bargain is real.",
            "Something beyond the veil whispered your name while I worked, %s. I told it to wait. It does not like waiting.",
            "I have died, %s. I remember the cold, and the things that move in it. You will not go there while I hold this stone.",
            "Your soul hums in my hand, %s. The demons can smell it. Let them hunger. It is mine to spend, not theirs.",
            "The binding is done, %s. Death may take you, but only on loan, and I always collect what is owed.",
            "Feel that, %s? A cold hook behind your ribs. That is me. Should you fall, I pull, and the grave lets go.",
            "Every stone I make costs me a little more of myself, %s. One day the Nether will want its due. Not today.",
            "I bled into the shard to bind you, %s. The fel fire liked the taste. Try not to die. It may want more.",
            "Do not thank me, %s. A soul dragged back through shadow comes back changed. Ask any of the Forsaken.",
            "There. Your soul, %s, caged in the stone like an ember in the dark. The Nether claws at the walls. Let it.",
            "I can hear the hunger behind the veil, %s. It thinks your soul belongs to it. It is wrong. You belong to me.",
        },
        selfEmotes = {
            "splits off a sliver of soul and locks it in a Soulstone, out of death's reach.",
            "crushes a soul shard and seals a piece of the warlock's own soul inside a Soulstone, a way back from the grave.",
            "places a Soulstone on self, grinning as the cold of it settles behind the ribs.",
            "grips a fresh Soulstone until dead fingers smoke. If this body falls, the soul will return.",
        },
        selfLines = {
            "I tear a piece of my own soul loose and bind it in stone. It hurts. It is a good pain. It means I am still mine.",
            "Death took me once and let me go. If it wants me back, it will have to pry me out of the stone.",
            "I can feel the Nether pulling at the edges of me. Let it pull. There is more of me in the stone than it can reach.",
            "My soul, split and bottled. The demons circle it like wolves. Good. Let them learn what happens to things that bite.",
            "I have already been dead. The grave was cold and quiet, and it could not keep me. It will not keep me now.",
            "Fel fire runs through my veins as the stone takes hold. I should be afraid. Instead, I am hungry.",
            "Every stone cuts me thinner. One day the Nether may take what is left. Until then, death is an inconvenience.",
        },
    },

    -- Demon summons. No %s (the demon has no name yet when the line goes out).
    -- These get resummoned often; if they start to feel spammy, add
    -- chance = 0.5 (or lower) to a moment.

    imp = {
        emotes = {
            "summons an Imp. Flame spits up from the ground, and the cackling little demon crawls out of it.",
            "snaps at the fire until it grows a mouth, laughs, and becomes an Imp.",
            "calls an Imp out of the Nether. It arrives already muttering insults.",
        },
        lines = {
            "Out of the fire, little wretch. Burn what I point at, and keep your opinions to yourself.",
            "An imp. A spark of the Nether with a mouth on it. Still, it burns, and burning is enough.",
            "Every insult you mutter, imp, I will take out of your hide later. For now: fire.",
            "Small, spiteful, and mine. The Nether sends me its runts. I make them useful.",
            "Crawl out of the flames, imp. The world is full of things that need to burn.",
            "I can feel it grinning at me through the fire. Let it grin. The chain is in my hand.",
        },
    },

    voidwalker = {
        emotes = {
            "summons a Voidwalker. The light around it dims, and the dark itself stands up.",
            "tears open the space between worlds and summons a Voidwalker, hollow and silent.",
            "goes very still as cold pours out of nowhere and takes the shape of a Voidwalker.",
        },
        lines = {
            "Rise from the empty places, hollow one. There is pain to be taken, and you will take it for me.",
            "The void leaks through the tear and stands up. It hates me. It obeys me. That is our whole bond.",
            "Stand between me and the blades, shadow. Bleed darkness so I do not have to bleed at all.",
            "I tore you out of the silence between worlds. Do not mourn it. You will be back there soon enough.",
            "Feel that cold? That is the void looking through. Rise, servant, and swallow their fury.",
            "You were nothing, and I gave you a purpose. Suffer well.",
        },
    },

    succubus = {
        emotes = {
            "summons a Succubus. The shadows part with the crack of a whip.",
            "traces a slow sigil in the air, and a Succubus steps out of it, laughing low and sweet.",
            "breathes a name into the dark and summons a Succubus, perfumed with brimstone.",
        },
        lines = {
            "Come, mistress. Your whip is sharp and your smile is sharper. Remember whose chain you wear.",
            "She steps out of the fire as if she owns it. She does not. I do.",
            "Charm them, cut them, break them. Just never forget that I know your true name.",
            "A demon of want and pain. The two were never so different, mistress, were they?",
            "Every sweet thing she offers is a hook. I have felt them all. They no longer catch me.",
            "Dance for them, lovely. When the dancing stops, the screaming starts.",
        },
    },

    felhunter = {
        emotes = {
            "summons a Felhunter. It slinks out of the dark with a wet, eager snuffle.",
            "pulls a thread of shadow taut and summons a Felhunter, all tendrils and hunger.",
            "offers a palm of raw arcane light and summons a Felhunter to feed on it.",
        },
        lines = {
            "Come, hound of the Nether. I can feel the magic in the air, and so can you. Feed.",
            "It smells the spells on them before they ever speak. Hunt, beast. Drink them dry.",
            "Out of the dark it comes, all tendrils and hunger. Every mage in sight just became prey.",
            "Every spell they cast is a meal I have promised you. Go and collect.",
            "The felhunter does not hate them. It does not have to. It is hungry, and they glow.",
            "Heel, beast. Wait. Let them begin to chant. Now.",
        },
    },

    infernal = {
        emotes = {
            "calls down an Infernal from the sky. Far above, the clouds begin to glow.",
            "speaks one burning word upward, summoning an Infernal to crash down like a falling star.",
            "drags a hand down through the air, pulling an Infernal out of the stars.",
        },
        lines = {
            "Hear the sky crack. Something is falling, and I am the one who threw it.",
            "From the burning dark beyond the stars, I call down ruin. Catch it if you can.",
            "Fall, burning one. Break the ground. Break them. Try not to break me.",
            "Listen to it scream as it falls. That is the sound of a demon learning who holds its leash.",
            "I pull a meteor out of the Nether and drop it on their heads. Some days I adore this work.",
            "Look up. The Nether is answering, and it answers in fire.",
        },
    },

    doomguard = {
        emotes = {
            "begins the Ritual of Doom, cutting a palm and letting the blood fall into the circle.",
            "chants the Ritual of Doom until the voice is no longer entirely the warlock's own.",
            "begins the Ritual of Doom to summon a Doomguard. The ground cracks, and the Doomguard starts to climb out.",
        },
        lines = {
            "The circle is drawn and the price is blood. One of us pays it. The Nether chooses who.",
            "By pain and blood I open the gate. A lord of ruin answers, and it is not grateful.",
            "Stand fast. What comes through now does not serve willingly. If my will breaks, run.",
            "Doom has a shape tonight, and I have called it by its name.",
            "The ritual takes its due in flesh. Do not look away. Look at what we bought.",
            "I can feel the gate fighting me. Good. The things worth calling always fight.",
        },
    },

    -- Cannibalize (Forsaken racial). No %s: the corpse is usually not your
    -- target. You use this a lot while leveling; add chance = 0.5 if it
    -- gets to be too much, or channel = "EMOTE" to keep the line off /say.
    cannibalize = {
        emotes = {
            "kneels over a corpse and begins to eat it, unhurried, as if this were the most natural thing in the world.",
            "tears into the corpse and feeds on it. Nobody watches for long.",
            "crouches beside the fallen and eats the dead flesh. The warlock's own wounds slowly knit closed.",
            "pulls a strip of cold flesh from the corpse and chews, eyes half-closed, almost reverent.",
            "drops to a crouch and starts eating the body. The sounds that follow are not polite.",
            "feeds on the corpse to mend wounds. Somewhere beyond the veil, something hungry approves.",
        },
        lines = {
            "Do not look at me like that. The dead feed the dead. It is the oldest law there is.",
            "Still warm. A pity. They are always better cold.",
            "Your life ended. Mine did too, once. Now yours keeps mine going a little longer.",
            "The Scourge taught me hunger. The Banshee Queen gave me purpose. Tonight, I simply eat.",
            "Waste not. The Nether takes the souls. I take what is left.",
            "Every wound you gave me, you will now repay. Bite by bite.",
            "I was a corpse once. I know exactly what you are worth.",
            "Hold still. Ah. You already are.",
        },
    },

    -- Mounts: emote only, and only a quarter of the time, because you
    -- mount constantly. Raise `chance` or add lines if you want more.
    felsteed = {
        chance = 0.25,
        emotes = {
            "summons a Felsteed. Hooves of fire strike the earth.",
            "whistles once, and a Felsteed tears out of the Nether, mane burning.",
            "calls a Felsteed from the Nether. The ground scorches where it lands.",
        },
    },

    dreadsteed = {
        chance = 0.25,
        emotes = {
            "summons a Dreadsteed. The air shudders as it gallops out of the Nether.",
            "calls the Dreadsteed, bound by an old and bloody bargain. Its hooves leave burning prints.",
            "summons a Dreadsteed, black fire streaming from its mane.",
        },
    },

    -- ===================== SHAMAN (Aelith) =====================
    -- Later.
}
