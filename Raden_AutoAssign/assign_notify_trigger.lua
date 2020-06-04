function(event, spot, case, name)

    aura_env.message = ""
    aura_env.iconid = ""
    if event == "NS_RADEN_BACKUP_NOTIFY" then
        aura_env.message = ""
        if case == "Vita" then
            aura_env.message = "请你准备替补: 传电 第 "..spot.." 棒"
        elseif case == "Void" then
            aura_env.message = "请你准备替补: 踩黑圈 第 "..spot.." 棒"
        elseif case == "Nightmare" then
            aura_env.message = "请你准备替补: 传红圈 第 "..spot.." 棒"
        end
    elseif event == "NS_RADEN_NEXT_NOTIFY" then
        aura_env.message = ""
        if spot == "Vita" then
            if case then
                aura_env.message = "下一个传电轮到你了！位置{rt"..case.."}，快去就位！"
                aura_env.iconid = case
            else
                aura_env.message = "下一个传电轮到你了！快去就位！"
                aura_env.iconid = "8" -- skull by default
            end
        elseif spot == "Void" then
            aura_env.message = "下一个踩黑圈{rt3}轮到你了！ 快去就位！"
            aura_env.iconid = "3"
        elseif spot == "Nightmare" then
            if case == 1 then
                aura_env.iconid = "5" -- moon
            else
                aura_env.iconid = "7" -- cross
            aura_env.message = "下一个传红圈{rt"..aura_env.iconid.."}轮到你了！ 靠近红圈！"
            end
        end
    end

    if aura_env.message ~= "" then
        C_Timer.After(0.5, function()
            SendChatMessage(aura_env.message , "WHISPER", nil, name)
        end)

        -- SendChatMessage(aura_env.message , "WHISPER", nil, name)
        if aura_env.iconid ~= "" then
            C_Timer.After(0.5, function()
                SetRaidTarget(name, tonumber(aura_env.iconid))
            end)

            -- SetRaidTarget(name, tonumber(aura_env.iconid))
        end
        return true
    end
end
