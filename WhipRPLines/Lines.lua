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
--   speak       Set to false to send only the emote. The spoken lines stay
--               in the file, so setting it back to true restores them.
--   chance      0 to 1. Chance the moment fires at all (1 = always, default).
--               Lower it for things you cast often. The spell is still cast.
--   speakChance 0 to 1. Chance the spoken line is sent (default 1). The emote
--               still fires every time; only the line is rolled.
--   whisper     Set to true to also whisper the spoken line to the `unit`
--               player (e.g. the person you are summoning, who is too far
--               away to hear /say). Only when a line is actually sent.
--
-- Nothing repeats twice in a row.

local _, ns = ...

ns.moments = {

    -- ===================== WARLOCK =====================

    -- Ritual of Summoning. Target the player you are summoning. The line is
    -- said aloud and whispered to them, so both ends read the same thing.
    summon = {
        unit = "target",
        whisper = true,
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
            "Come, %s. I crossed the grave once and came back. Crossing the Nether is nothing. For me, at least.",
            "I call, %s, and the Nether carries you. It will want a toll for the ride. I have already paid it in blood.",
            "Hold still, %s. The Nether is stripping you to the bone and putting you back together. Mostly in the right order.",
            "Something in the dark just learned your name, %s. I gave it to them. It was the price.",
            "The Nether does not carry the living for free, %s. It took a little of you. You will not miss it. Probably.",
            "I am dragging you through the place where souls go to be eaten, %s. Keep yours close.",
            "%s, if you hear whispering on the way through, do not answer. Not ever.",
            "Pain is the thread I pull you along, %s. Mine, and now yours. Feel how it burns.",
            "The last one I summoned came through screaming, %s. You can choose to come through quietly.",
            "Your heartbeat is very loud from here, %s. The Nether hears it too. Come before it gets hungry.",
            "I am the door, %s. Walk through me and try not to look at what I keep inside.",
            "I died once and the dark kept me, %s. Now I lend you to it, just for a moment. It always gives you back. Usually.",
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

    -- Demon summons. Emote only (speak = false); set speak = true on a
    -- demon to say its lines again. No %s in these.
    -- These get resummoned often; if they start to feel spammy, add
    -- chance = 0.5 (or lower) to a moment.

    imp = {
        speak = false,
        emotes = {
            "summons an Imp. Flame spits up from the ground, and the cackling little demon crawls out of it.",
            "snaps at the fire until it grows a mouth, laughs, and becomes an Imp.",
            "calls an Imp out of the Nether. It arrives already muttering insults.",
            "summons an Imp with a flick of the wrist. It lands in a puff of sulfur, already complaining.",
            "pricks a finger and lets one drop of blood hiss onto the ground. An Imp bursts out of the steam.",
            "summons an Imp, holding it up by the scruff for a moment before letting it drop.",
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
        speak = false,
        emotes = {
            "summons a Voidwalker. The light around it dims, and the dark itself stands up.",
            "tears open the space between worlds and summons a Voidwalker, hollow and silent.",
            "goes very still as cold pours out of nowhere and takes the shape of a Voidwalker.",
            "summons a Voidwalker. Frost creeps over the ground as the hollow shape rises.",
            "speaks into the silence between heartbeats, and a Voidwalker pours out of it.",
            "summons a Voidwalker and watches it bow low, every movement full of quiet hatred.",
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
        speak = false,
        emotes = {
            "summons a Succubus. The shadows part with the crack of a whip.",
            "traces a slow sigil in the air, and a Succubus steps out of it, laughing low and sweet.",
            "breathes a name into the dark and summons a Succubus, perfumed with brimstone.",
            "summons a Succubus. She steps out of a ring of violet flame, smiling as if she already knows a secret.",
            "beckons with one finger and summons a Succubus, who answers with a slow, mocking curtsy.",
            "summons a Succubus. The air turns warm and sweet, then sharp with the smell of brimstone.",
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
        speak = false,
        emotes = {
            "summons a Felhunter. It slinks out of the dark with a wet, eager snuffle.",
            "pulls a thread of shadow taut and summons a Felhunter, all tendrils and hunger.",
            "offers a palm of raw arcane light and summons a Felhunter to feed on it.",
            "summons a Felhunter. The beast circles once, tendrils twitching toward every nearby spell.",
            "taps the ground twice, and a Felhunter claws its way up out of the shadows.",
            "summons a Felhunter, which immediately sniffs at the warlock's hands for leftover magic.",
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
        speak = false,
        emotes = {
            "calls down an Infernal from the sky. Far above, the clouds begin to glow.",
            "speaks one burning word upward, summoning an Infernal to crash down like a falling star.",
            "drags a hand down through the air, pulling an Infernal out of the stars.",
            "points at the ground, and an Infernal smashes down from the sky in a burst of green fire.",
            "summons an Infernal. A burning stone streaks across the sky and craters the earth.",
            "calls an Infernal down from the heavens. The impact shakes the ground for a long moment.",
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
        speak = false,
        emotes = {
            "begins the Ritual of Doom, cutting a palm and letting the blood fall into the circle.",
            "chants the Ritual of Doom until the voice is no longer entirely the warlock's own.",
            "begins the Ritual of Doom to summon a Doomguard. The ground cracks, and the Doomguard starts to climb out.",
            "leads the Ritual of Doom, voice rising as the circle begins to burn.",
            "begins the Ritual of Doom. The circle glows red, and a terrible voice answers from below.",
            "begins the Ritual of Doom, drawing the circle in fel fire while the others hold their places.",
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
    -- target. You use this a lot while leveling, so the emote fires every
    -- time but the /say line only half the time.
    cannibalize = {
        speakChance = 0.5,
        emotes = {
            "kneels over a corpse and begins to eat it, unhurried, as if this were the most natural thing in the world.",
            "tears into the corpse and feeds on it. Nobody watches for long.",
            "crouches beside the fallen and eats the dead flesh. The warlock's own wounds slowly knit closed.",
            "pulls a strip of cold flesh from the corpse and chews, eyes half-closed, almost reverent.",
            "drops to a crouch and starts eating the body. The sounds that follow are not polite.",
            "feeds on the corpse to mend wounds. Somewhere beyond the veil, something hungry approves.",
            "feeds on the corpse with dreadful enthusiasm.",
            "finishes eating the corpse, wipes a hand on the robes and sighs, satisfied.",
            "eats from the corpse like a ghoul, then dabs at the corners of the mouth, ever so politely.",
            "tears a strip from the corpse and chews thoughtfully.",
            "crouches over the body to feed and makes unpleasant noises.",
            "feeds on the corpse, pausing only to pick something out of the teeth.",
            "eats the corpse with the quiet focus of someone doing a crossword.",
            "kneels to feed on the corpse and hums a tuneless little song while chewing.",
            "feeds on the corpse, then glances up as if daring anyone to comment.",
            "drags the corpse a little closer and digs in.",
            "eats from the corpse, loose stitches tightening as the flesh goes down.",
            "crouches to feed and swats away a fly that had the same idea.",
            "feeds on the dead, slow and deliberate, savoring every bite.",
            "eats the corpse and lets out a small, contented burp.",
            "kneels to feed. The jaw makes a sound jaws should not make.",
            "feeds on the corpse, fel-green eyes never leaving the horizon.",
            "eats the corpse, then tucks a scrap away in a pouch for later.",
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
            -- Short and silly ones, on purpose: you cast this constantly.
            "Nom nom nom. Delicious.",
            "Mmm. Crunchy.",
            "Waste not.",
            "Still warm. Lucky me.",
            "Five-second rule.",
            "Needs salt.",
            "The Lich King never fed us this well.",
            "Rot is just flavor with patience.",
            "One corpse's end is another corpse's lunch.",
            "Tastes exactly like I expected.",
            "Mmm. Vintage.",
            "Leftovers!",
            "Could use a garnish.",
            "Free lunch.",
            "Chef's kiss.",
            "Second breakfast.",
            "Everything ends up as food for something. Today, that something is me.",
            "Flesh mends flesh. The Nether is not the only thing that hungers.",
            "I remember being alive. I don't remember being this well fed.",
            "You fought hard. You'll mend me just as hard.",
            "Every bite is a wound closing. Every wound is a lesson.",
            "The living fear the grave. The grave fears me.",
            "Your soul went to the Nether. The rest of you is mine.",
            "The dead keep no secrets. They taste of every one.",
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
