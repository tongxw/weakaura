function(allstates,event,prefix,message,channel,sender)
    if event == "CHAT_MSG_ADDON" and message == "toggle" and prefix == "ThermoosIlly" then
        allstates[sender] = allstates[sender] or {}
        local state = allstates[sender]
        if state.show == true then
            state.show = false
            state.changed = true    
        else 
            state.show = true
            state.show = true
            state.changed = true
            state.progressType = 'static'
            state.name = sender
            state.unit = aura_env.GetUnitFromFullName(sender)
            local options = WeakAurasSaved['displays'][aura_env.id]
            local frame = WeakAuras.GetUnitFrame(state.unit)
            if frame then
                options.width = frame:GetWidth()
                options.height = frame:GetHeight()
            end
        end
        return true   
    elseif event == "CHAT_MSG_ADDON" and message == "off" and prefix == "ThermoosIlly" then
        local state = allstates[sender]
        state.show = false
        state.changed = true
        return true
    elseif event == "CHAT_MSG_ADDON" and message == "reset" and prefix == "ThermoosIlly" then
        for _, state in pairs(allstates) do
            state.show = false
            state.changed = true
        end
        return true
    elseif event == "ENCOUNTER_START" then
        for _, state in pairs(allstates) do
            state.show = false
            state.changed = true
        end
        return true
    end
end

