function(event, spot, case)
    
    if event == "NS_RADEN_BACKUP_NOTIFY" then
        aura_env.message = ""
        if case == "Vita" then
            aura_env.message = "请准备替补: 传电 第 "..spot.." 棒"
            return true
        elseif case == "Void" then
            aura_env.message = "请准备替补: 踩黑圈 第 "..spot.." 棒"
            return true
        elseif case == "Nightmare" then
            aura_env.message = "请准备替补: 传红圈 第 "..spot.." 棒"
            return true
        end
    elseif event == "NS_RADEN_NEXT_NOTIFY" then
        aura_env.message = ""
        if spot == "Vita" then
            if case then
                aura_env.message = "下一棒传电 轮到你了！位置{rt"..case.."}请准备就位！{rt"..case.."}"
                return true
            else
                aura_env.message = "下一棒传电 轮到你了！请准备就位！"
                return true
            end
        elseif spot == "Void" then
            aura_env.message = "下一棒踩黑圈{rt3} 轮到你了！ 请准备面壁！{rt3}"
            return true
        elseif spot == "Nightmare" then
            aura_env.message = "下一棒传红圈{rt7} 轮到你了！ 注意靠近红圈位置！{rt7}"
            return true
        end
    end
  end