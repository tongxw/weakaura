events: CLEU:SPELL_DAMAGE:SPELL_MISSED:SPELL_AURA_REMOVED WA_CANCEL_PULSE

function(states, event, ...)
    if event == "OPTIONS" then
        local sound = aura_env.config.sound
        states[""] = {
            name = "Cursed Pulse",
            icon = 1392546,
            amount = AbbreviateNumbers(123456),
            additionalProgress = {{min=0, max=-0.5}},
            sound = sound,
            progressType = "timed",
            duration = 19.2,
            expirationTime = GetTime() + 19.2,
            autoHide = true,
            changed = true,
            show = true
        }
        aura_env.show()
        return true
    end
    
    if event == "COMBAT_LOG_EVENT_UNFILTERED" and ... then
        local _, message, _, srcGUID, srcName, _, _, destGUID, destName, _, destRaidFlags, spellid, _, _, arg1, _, arg2 = ...
        local t = WeakAuras.triggerState[aura_env.id].triggers
        
        if t[2] then
            if message == "SPELL_DAMAGE" and spellid == 316813 and destGUID == WeakAuras.myGUID then
                --raw spell damage taken
                C_ChatInfo.SendAddonMessage("ThermoosIlly", "off", "RAID")
                if not states[""] or states[""].expirationTime - GetTime() <= 0.2 then
                    local sound = aura_env.config.sound
                    states[""] = {
                        name = "Cursed Pulse",
                        icon = 1392546,
                        amount = AbbreviateNumbers(arg1),
                        additionalProgress = {{min=0, max=-0.5}},
                        sound = sound,
                        progressType = "timed",
                        duration = 19.2,
                        expirationTime = GetTime() + 19.2,
                        autoHide = true,
                        changed = true,
                        show = true
                    }
                end
            elseif message == "SPELL_MISSED" and spellid == 316813 and destGUID == WeakAuras.myGUID and arg1 == "ABSORB" then
                --full spell damage absorbed
                C_ChatInfo.SendAddonMessage("ThermoosIlly", "off", "RAID")
                if not states[""] or states[""].expirationTime - GetTime() <= 0.2 then
                    local sound = aura_env.config.sound
                    states[""] = {
                        name = "Cursed Pulse",
                        icon = 1392546,
                        amount = AbbreviateNumbers(arg2),
                        additionalProgress = {{min=0, max=-0.5}},
                        sound = sound,
                        progressType = "timed",
                        duration = 19.2,
                        expirationTime = GetTime() + 19.2,
                        autoHide = true,
                        changed = true,
                        show = true
                    }
                end
            end
        end
        
        if message == "SPELL_AURA_REMOVED" and spellid == 313759 and destGUID == WeakAuras.myGUID and states[""] then
            states[""].show = false
            states[""].changed = true
            C_ChatInfo.SendAddonMessage("ThermoosIlly", "off", "RAID")
        end
        
    end
    
    if event == "WA_CANCEL_PULSE" and ... and states[""] then
        states[""].show = false
        states[""].changed = true
        C_ChatInfo.SendAddonMessage("ThermoosIlly", "off", "RAID")
    end
    
    return true
end


{
    expirationTime = true,
    sound = "bool",
    additionalProgress = {
        [1] = {}
    },
}

