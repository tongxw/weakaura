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


