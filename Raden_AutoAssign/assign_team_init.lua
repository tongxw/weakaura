aura_env.cycle = 6
aura_env.vitacount = 0
aura_env.spells = { -- buff on boss
    ["Vita"] = 306732,
    ["Void"] = 306733,
    ["Nightmare"] = 312996,
    
}
aura_env.team1 = {}
aura_env.backup = {}
aura_env.count = 0
aura_env.unit = "boss1"
aura_env.fd = 5384

aura_env.debuffs = { -- debuffs on players
    ["Vita"] = 306273,
    ["Void"] = 306733,
    ["Nightmare"] = 313077,
    
}

aura_env.orb = {
    [1] = "Vita",
    [2] = "Void",
    [3] = "Nightmare"
    
}

aura_env.essence = 306090
aura_env.vuln = 306279
aura_env.type = {
    [1] = aura_env.orb[aura_env.config["debuff1"]],
    [2] = aura_env.orb[aura_env.config["debuff2"]],
    [3] = aura_env.orb[aura_env.config["debuff3"]],
    [4] = aura_env.orb[aura_env.config["debuff1"]],
    [5] = aura_env.orb[aura_env.config["debuff2"]],
    [6] = aura_env.orb[aura_env.config["debuff3"]],
    [7] = aura_env.orb[aura_env.config["debuff1"]],
    [8] = aura_env.orb[aura_env.config["debuff2"]],
    [9] = aura_env.orb[aura_env.config["debuff3"]],
}

if aura_env.config["debug"] then
    aura_env.debug = "HELPFUL"
else 
    aura_env.debug = "HARMFUL"
end

if aura_env.debug == "HELPFUL" then
    aura_env.spells = {
        ["Vita"] = 102351, -- Cenarion Ward
        ["Void"] = 289318, -- Mark of the Wild
        ["Nightmare"] = 3714, -- Path of Frost
        
    }
    
    aura_env.debuffs = {
        ["Vita"] = 33763, -- Lifebloom
        ["Void"] = 2893180, -- Mark of the Wild
        ["Nightmare"] = 8936, -- Regrowth
        
    }
    aura_env.vuln = 774 -- Reju
    aura_env.essence = 48438 -- Wild Growth
    aura_env.unit = "player"
end

aura_env.text = {
    
    ["Vita"] = "|cFF00E6E6Vita: ",
    ["Void"] =  "|cFF6A0DADVoid: ",
    ["Nightmare"] = "|cFF800015Nightmare: ",
}

aura_env.icons = { 
    [8] =
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:12\124t",
    [7] =
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:12\124t",
    [6] =
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:12\124t",
    [5] =
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:12\124t",
    [4] =
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:12\124t",
    [3] =
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:12\124t",
    [2] =
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:12\124t",
    [1]  = 
    " \124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:12\124t",       
}


aura_env.markone = {aura_env.config["markone"], aura_env.config["markonecopy"], aura_env.config["markone"], aura_env.config["markonecopy"]}
aura_env.marktwo = {aura_env.config["marktwo"], aura_env.config["marktwocopy"], aura_env.config["marktwo"], aura_env.config["marktwocopy"]}



aura_env.colorcode = function(name)
    local length = string.len(name)
    if string.sub(name, 2, 3) == "|c" then
        if string.sub(name, length-1) == "|r" then
            return string.sub(name, 12, length-3)
        else
            return string.sub(name, 12)
        end
    elseif string.sub(name, length-1) == "|r" then
        return string.sub(name, 1, length-3)
    else
        return name
    end
end

-- scan ERT combat tactics to get player names
aura_env.ERT = function()
    local text = _G.VExRT.Note.Text1
    aura_env.assign = true
    aura_env.assign1 = false
    aura_env.assign2 = false
    aura_env.vitacount = 0
    aura_env.team = {}
    aura_env.backup = {}
    for line in string.gmatch(text,'[^\r\n]+') do
        local start = strsplit(" ", line)
        if string.lower(start) == "end" then
            aura_env.assign = false
            return true
            
        elseif string.lower(start) == "team2" or string.lower(start) == "backup2" then
            aura_env.assign2 = false
            aura_env.assign1 = false
            
        elseif string.lower(start) == "team1" then
            aura_env.assign1 = true
        elseif string.lower(start) == "backup1" then
            aura_env.assign2 = true
            aura_env.assign1 = false
            
        elseif aura_env.assign1 and aura_env.assign then
            local name = start
            local length = string.len(name)
            local length2 = string.len(name)
            name = aura_env.colorcode(name)
            table.insert(aura_env.team, name)
            
            
        elseif aura_env.assign2 and aura_env.assign then
            local name = start
            local length = string.len(name)
            local length2 = string.len(name)
            name = aura_env.colorcode(name)
            table.insert(aura_env.backup, name)
        end
    end
    
end


