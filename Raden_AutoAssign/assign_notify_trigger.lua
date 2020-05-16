function(event, spot, case, name)

    aura_env.message = ""
    aura_env.iconid = ""
    if event == "NS_RADEN_BACKUP_NOTIFY" then
        aura_env.message = ""
        if case == "Vita" then
            local vitapos = "6" --circle
            if case % 2 == 0 then
                vitapos = "2" --square
            end
            aura_env.message = "请你准备替补: 传电 第 "..spot.." 棒 位置{rt" ..vitapos.."}"
        elseif case == "Void" then
            aura_env.message = "请你准备替补: 踩黑圈 第 "..spot.." 棒"
        elseif case == "Nightmare" then
            aura_env.message = "请你准备替补: 传红圈 第 "..spot.." 棒"
        end
    elseif event == "NS_RADEN_NEXT_NOTIFY" then
        aura_env.message = ""
        if spot == "Vita" then
            if case then
                aura_env.message = "下一棒传电 轮到你了！位置{rt"..case.."}，快就位！"
                aura_env.iconid = case
            else
                aura_env.message = "下一棒传电 轮到你了！"
                aura_env.iconid = "8" -- skull by default
            end
        elseif spot == "Void" then
            aura_env.message = "下一棒踩黑圈{rt3} 轮到你了！ 快就位！"
            aura_env.iconid = "3"
        elseif spot == "Nightmare" then
            aura_env.message = "下一棒传红圈{rt7} 轮到你了！ 靠近红圈！"
            aura_env.iconid = "7"
        end
    end

    if aura_env.message ~= "" then
        SendChatMessage(aura_env.message , "WHISPER", nil, name)
        if aura_env.iconid ~= "" then
            SetRaidTarget(name, tonumber(aura_env.iconid))
        end
        return true
    end
  end