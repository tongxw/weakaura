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

aura_env.countdown = function(mark)
  C_Timer.After(3, function()
          SendChatMessage("{rt"..mark.."} 3 ".."{rt"..mark.."}", "SAY")
          C_Timer.After(1, function()
                  SendChatMessage("{rt"..mark.."} 2 ".."{rt"..mark.."}", "SAY")
                  C_Timer.After(1, function()
                          SendChatMessage("{rt"..mark.."} 1 ".."{rt"..mark.."}", "SAY")
                  end)
          end)
  end)
end



--------------------------------------------------------------------------------------------
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
aura_env.markch = {
  [1] = "|cfffef367星星|r",
  [2] = "|cfffe7b09大餅|r",
  [3] = "|cffa22fc8紫稜|r",
  [4] = "|cff55ee55三角|r",
  [5] = "月亮",
  [6] = "|cff3ec5e9方塊|r",
  [7] = "|cffc31d39紅叉|r",
  [8] = "|cff808080骷髏|r",
  [9] = " ",
  
  
}

aura_env.countdown = function(mark)
  if mark ~= 0 then
      C_Timer.After(3, function()
              SendChatMessage("{rt"..mark.."} 3 ".."{rt"..mark.."}", "SAY")
              C_Timer.After(1, function()
                      SendChatMessage("{rt"..mark.."} 2 ".."{rt"..mark.."}", "SAY")
                      C_Timer.After(1, function()
                              SendChatMessage("{rt"..mark.."} 1 ".."{rt"..mark.."}", "SAY")
                      end)
              end)
      end)
  else
      C_Timer.After(3, function()
              SendChatMessage(" 3 ", "SAY")
              C_Timer.After(1, function()
                      SendChatMessage(" 2 ", "SAY")
                      C_Timer.After(1, function()
                              SendChatMessage(" 1 ", "SAY")
                      end)
              end)
      end)
  end
  
end

