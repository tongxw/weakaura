function()
    if WeakAuras.IsOptionsOpen() then
        return "Testposition:\n"..WA_ClassColorName("player").."\n"..WA_ClassColorName("player").."\n"..WA_ClassColorName("player").."\n"..WA_ClassColorName("player").."\n"..WA_ClassColorName("player").."\n"..WA_ClassColorName("player")
    end
    aura_env.time = aura_env.time or GetTime()
    aura_env.result = aura_env.result or ""
    if GetTime() >= aura_env.time then
        if (aura_env.type[aura_env.count] == "Nightmare" or aura_env.type[aura_env.count] == "Void") and aura_env.one[6] then
            aura_env.one[6] = nil
        end
        aura_env.result = ""
        aura_env.time = GetTime()+0.25
        aura_env.result = aura_env.text[aura_env.type[aura_env.count]]
        aura_env.result = aura_env.result or ""
        
        aura_env.starttime = aura_env.starttime or GetTime()
        if not aura_env.alerted and aura_env.number ~= 0 and (GetTime()-aura_env.starttime) < 36 then
            local name = UnitName("player")
            local cycle = aura_env.cycle
            if aura_env.type[aura_env.count] == "Nightmare" then
                cycle = aura_env.cycle+0.4
            end
            local next = Round((GetTime()-aura_env.starttime-(cycle/2))/cycle)+2
            if aura_env.type[aura_env.count] == "Void" then
                next = next-1
            end
            
            
            if aura_env.number and aura_env.one and #aura_env.one >= next then
                if aura_env.one[next] == name then
                    aura_env.alerted = true
                    if aura_env.type[aura_env.count] == "Void" or aura_env.type[aura_env.count] == "Nightmare" then
                        WeakAuras.ScanEvents("NS_RADEN_NEXT", aura_env.type[aura_env.count])
                    else
                        if next % 2 == 0 then
                            WeakAuras.ScanEvents("NS_RADEN_NEXT", aura_env.type[aura_env.count], aura_env.marktwo[aura_env.vitacount])
                        else
                            WeakAuras.ScanEvents("NS_RADEN_NEXT", aura_env.type[aura_env.count], aura_env.markone[aura_env.vitacount])
                        end
                    end
                end
            end
        end
        

        -- add notification
        if not aura_env.notify_alerted and aura_env.number_backup ~= 0 and (GetTime()-aura_env.starttime) < 36 then
            local cycle = aura_env.cycle
            if aura_env.type[aura_env.count] == "Nightmare" then
                cycle = aura_env.cycle+0.4
            end
            local next = Round((GetTime()-aura_env.starttime-(cycle/2))/cycle)+2
            if aura_env.type[aura_env.count] == "Void" then
                next = next-1
            end
            
            
            if aura_env.number_backup and aura_env.one and #aura_env.one >= next then
                aura_env.notify_alerted = true -- do not repeat the notification
                if aura_env.type[aura_env.count] == "Void" or aura_env.type[aura_env.count] == "Nightmare" then
                    C_Timer.After(0.5, function()
                        WeakAuras.ScanEvents("NS_RADEN_NEXT_NOTIFY", aura_env.type[aura_env.count], "", aura_env.one[next])
                    end)
                    -- WeakAuras.ScanEvents("NS_RADEN_NEXT_NOTIFY", aura_env.type[aura_env.count], "", aura_env.one[next])
                else
                    if next % 2 == 0 then
                        C_Timer.After(0.5, function()
                            WeakAuras.ScanEvents("NS_RADEN_NEXT_NOTIFY", aura_env.type[aura_env.count], aura_env.marktwo[aura_env.vitacount], aura_env.one[next])
                        end)
                        -- WeakAuras.ScanEvents("NS_RADEN_NEXT_NOTIFY", aura_env.type[aura_env.count], aura_env.marktwo[aura_env.vitacount], aura_env.one[next])
                    else
                        C_Timer.After(0.5, function()
                            WeakAuras.ScanEvents("NS_RADEN_NEXT_NOTIFY", aura_env.type[aura_env.count], aura_env.markone[aura_env.vitacount], aura_env.one[next])
                        end)
                        -- WeakAuras.ScanEvents("NS_RADEN_NEXT_NOTIFY", aura_env.type[aura_env.count], aura_env.markone[aura_env.vitacount], aura_env.one[next])
                    end
                end
            end
        end



        
        if aura_env.one then
            local max = #aura_env.one
            if max > 6 then max = 6 end
            for i=1, max do
                aura_env.addtext = ""
                
                -- add order number
                -- if aura_env.type[aura_env.count] == "Void" then
                --     aura_env.addtext = tostring(i)
                -- else
                --     aura_env.addtext = tostring(i-1)
                -- end

                -- show player name in black if they are dead
                if UnitIsDead(aura_env.one[i]) then
                    aura_env.addtext = "|cFF808080[死]"..aura_env.one[i]
                 -- show player name in green if they are the current one
                elseif WA_GetUnitAura(aura_env.one[i], aura_env.debuffs[aura_env.type[aura_env.count]], aura_env.debug) then
                    local expires = select(6, WA_GetUnitAura(aura_env.one[i], aura_env.debuffs[aura_env.type[aura_env.count]], aura_env.debug))
                    local duration = Round(expires-GetTime())
                    aura_env.addtext = "|cFF00FF00"..aura_env.one[i].." - "..duration
                -- show player name in read if they have vulnerable debuff
                elseif WA_GetUnitAura(aura_env.one[i], aura_env.vuln, aura_env.debug) then
                    local expires = select(6, WA_GetUnitAura(aura_env.one[i], aura_env.vuln, aura_env.debug))
                    local duration = Round(expires-GetTime())
                    aura_env.addtext = "|cFFFF0000"..aura_env.one[i].." - "..duration
                else
                    aura_env.addtext = WA_ClassColorName(aura_env.one[i])
                end 
                
                -- add mark ahead of player name for vita
                if aura_env.type[aura_env.count] == "Vita" then
                    if i % 2 == 0 then
                        aura_env.addtext = aura_env.icons[aura_env.marktwo[aura_env.vitacount]].." "..aura_env.addtext 
                    else
                        aura_env.addtext = aura_env.icons[aura_env.markone[aura_env.vitacount]].." "..aura_env.addtext
                    end
                end
                -- aura_env.result = aura_env.result.."\n"..aura_env.addtext

                -- add order number at the first
                local order = i
                if aura_env.type[aura_env.count] == "Vita" then
                    order = order / 2
                else
                    order = order - 1
                end
                aura_env.addtext = order.." "..aura_env.addtext


                aura_env.result = aura_env.result.."\n"..aura_env.addtext

            end
        end
        
        
    end
    
    return aura_env.result
    
    
    
end
