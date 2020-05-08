function(event, spot, case)
    
  if event == "NS_RADEN_BACKUP" then
      aura_env.message = ""
      if case == "Vita" then
          aura_env.message = "替补: |cFF00E6E6传电 |cFFFFFFFF- 位置: "..spot
          return true
      elseif case == "Void" then
          aura_env.message = "替补: |cFF6A0DAD踩黑圈 |cFFFFFFFF- 位置: "..spot
          return true
      elseif case == "Nightmare" then
          aura_env.message = "替补: |cFF800015传红圈 |cFFFFFFFF- 位置: "..spot
          return true
      end
  elseif event == "NS_RADEN_NEXT" then
      aura_env.message = ""
      if spot == "Vita" then
          if case then
              aura_env.message = aura_env.icons[case].."下一个 |cFF00E6E6传电"..aura_env.icons[case]
              SendChatMessage("{rt"..case.."} 下一个 "..UnitName("player").." {rt"..case.."}", "SAY")
              C_ChatInfo.SendAddonMessage("NS_RADEN_GLOW", "1", "RAID") 
              C_Timer.After(6, function()
                      C_ChatInfo.SendAddonMessage("NS_RADEN_UNGLOW", "1", "RAID") 
              end)
              aura_env.countdown(case)
              return true
          else
              SendChatMessage("下一个 "..UnitName("player"), "SAY")
              C_ChatInfo.SendAddonMessage("NS_RADEN_GLOW", "1", "RAID") 
              C_Timer.After(6, function()
                      C_ChatInfo.SendAddonMessage("NS_RADEN_UNGLOW", "2", "RAID") 
              end)
              aura_env.message = "下一个 |cFF00E6E6传电"
              return true
          end
      elseif spot == "Void" then
          SendChatMessage("{rt3} 下一个 "..UnitName("player").." {rt3}", "SAY")
          C_ChatInfo.SendAddonMessage("NS_RADEN_GLOW", "2", "RAID") 
          C_Timer.After(6, function()
                  C_ChatInfo.SendAddonMessage("NS_RADEN_UNGLOW", "2", "RAID") 
          end)
          aura_env.countdown(3)
          aura_env.message = "下一个 |cFF6A0DAD踩黑圈"
          return true
      elseif spot == "Nightmare" then
          SendChatMessage("{rt7} 下一个 "..UnitName("player").." {rt7}", "SAY")
          aura_env.countdown(7)
          aura_env.message = "下一个 |cFF800015传红圈"
          return true
      end
  end
end


------------------------------------------------------------------------------------------------

function(event, spot, case)
    
  if event == "NS_RADEN_BACKUP" then
      aura_env.message = ""
      if case == "Vita" then
          aura_env.message = "替补: |cFF00E6E6传电|r |cFFFFFFFF- 位置: |r"..spot
          return true
      elseif case == "Void" then
          aura_env.message = "替补: |cFF6A0DAD接黑圈|r |cFFFFFFFF- 位置: |r"..spot
          return true
      elseif case == "Nightmare" then
          aura_env.message = "替补: |cFF800015传红圈|r |cFFFFFFFF- 位置:|r "..spot
          return true
      end
  elseif event == "NS_RADEN_NEXT" then
      aura_env.message = ""
      if spot == "Vita" then
          if case then
              if case == 9 or case =="9" then
                  aura_env.message = "下一棒 |cFF00E6E6传电|r-"
                  SendChatMessage("下一棒- "..UnitName("player").."", "SAY")
                  C_ChatInfo.SendAddonMessage("NS_RADEN_GLOW", "1", "RAID") 
                  C_Timer.After(6, function()
                          C_ChatInfo.SendAddonMessage("NS_RADEN_UNGLOW", "1", "RAID") 
                  end)
                  aura_env.countdown(0)
                  return true
              else
              aura_env.message = aura_env.icons[case].."下一棒 |cFF00E6E6传电|r-"..aura_env.markch[case]..aura_env.icons[case]
              SendChatMessage("{rt"..case.."} 下一棒- "..UnitName("player").." {rt"..case.."}", "SAY")
              C_ChatInfo.SendAddonMessage("NS_RADEN_GLOW", "1", "RAID") 
              C_Timer.After(6, function()
                      C_ChatInfo.SendAddonMessage("NS_RADEN_UNGLOW", "1", "RAID") 
              end)
              aura_env.countdown(case)
              return true
              end
          else
              SendChatMessage("下一棒- "..UnitName("player"))
              C_ChatInfo.SendAddonMessage("NS_RADEN_GLOW", "1", "RAID") 
              C_Timer.After(6, function()
                      C_ChatInfo.SendAddonMessage("NS_RADEN_UNGLOW", "1", "RAID") 
              end)
              aura_env.countdown(0)
              aura_env.message = "下一棒 |cFF00E6E6传电|r"
              return true
          end
      elseif spot == "Void" then
          SendChatMessage("{rt3} 下一棒- "..UnitName("player").." {rt3}", "SAY")
          C_ChatInfo.SendAddonMessage("NS_RADEN_GLOW", "2", "RAID") 
          C_Timer.After(6, function()
                  C_ChatInfo.SendAddonMessage("NS_RADEN_UNGLOW", "2", "RAID") 
          end)
          aura_env.countdown(3)
          aura_env.message = "下一棒 |cFF6A0DAD接黑圈|r"
          return true
      elseif spot == "Nightmare" then
          SendChatMessage("{rt7} 下一棒- "..UnitName("player").." {rt7}", "SAY")
          aura_env.countdown(7)
          aura_env.message = "下一棒 |cFF800015传红圈|r"
          return true
      end
  end
end

