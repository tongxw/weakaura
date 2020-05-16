-- trigger events
events = { CLEU:SPELL_CAST_SUCCESS, CLEU:SPELL_AURA_APPLIED, CLEU:SPELL_AURA_REMOVED, CLEU:UNIT_DIED, ENCOUNTER_START, ENCOUNTER_END };

-- Team 1 Mythic
aura_take_effect = function(event, ...)
  if event == "COMBAT_LOG_EVENT_UNFILTERED" then
      local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID,
            destName, destFlags, destRaidFlags, spellID, spellName, spellschool, extraspellID, extraspellName  = ...
      
      
      -- backup on death or other debuff applied
      if (subevent == "UNIT_DIED" and not UnitIsFeignDeath(destName) and not aura_env.vulnerable[destName]) 
      or (subevent == "SPELL_AURA_APPLIED" 
          and (spellID == aura_env.debuffs["Vita"] or spellID == aura_env.debuffs["Nightmare"])
          and spellID ~= aura_env.debuffs[aura_env.type[aura_env.count]]
          and not aura_env.vulnerable[destName])  then
          for i=1, #aura_env.one do -- aura_env.one list contains all players that already have the vita or void or nightmare
              if aura_env.one[i] == destName then -- the current player who has the spell is in the rotaion list. now we need a backup.
                  for j=1, #aura_env.backup do
                      if not UnitIsDead(aura_env.backup[j]) 
                      and not WA_GetUnitAura(aura_env.backup[j], aura_env.debuffs["Vita"], aura_env.debug) 
                      and not WA_GetUnitAura(aura_env.backup[j], aura_env.debuffs["Nightmare"], aura_env.debug) 
                      and not aura_env.assigned[aura_env.backup[j]] then
                          if WA_GetUnitAura(aura_env.backup[j], aura_env.vuln, aura_env.debug) then
                              -- this backup player has the vulnerable debuff, further check if it will be expired in time
                              local expires = select(6, WA_GetUnitAura(aura_env.backup[j], aura_env.vuln, aura_env.debug))
                              if Round(expires-GetTime()) < i*aura_env.cycle then
                                  aura_env.assigned[aura_env.backup[j]] = true
                                  aura_env.one[i] = aura_env.backup[j]
                                  if UnitIsUnit(aura_env.backup[j], "player") then
                                      WeakAuras.ScanEvents("NS_RADEN_BACKUP", i, aura_env.type[aura_env.count])
                                      aura_env.number = true
                                  end

                                  -- send notificiation
                                  WeakAuras.ScanEvents("NS_RADEN_BACKUP_NOTIFY", i, aura_env.type[aura_env.count], aura_env.backup[j])
                                  aura_env.number_backup = true
                                  break
                              end
                          else
                              aura_env.assigned[aura_env.backup[j]] = true
                              aura_env.one[i] = aura_env.backup[j]
                              if UnitIsUnit(aura_env.backup[j], "player") then
                                  WeakAuras.ScanEvents("NS_RADEN_BACKUP", i, aura_env.type[aura_env.count])
                                  aura_env.number = true
                              end

                              -- send notificiation
                              WeakAuras.ScanEvents("NS_RADEN_BACKUP_NOTIFY", i, aura_env.type[aura_env.count], aura_env.backup[j])
                              aura_env.number_backup = true
                              break
                          end 
                      end
                  end
                  break
              end
          end
      end
      
      if subevent == "SPELL_AURA_APPLIED" and (spellID == aura_env.vuln or spellID == aura_env.spells[aura_env.type[aura_env.count]]) then
          local aura_env = aura_env
          C_Timer.After(0.5, function()
                  aura_env.vulnerable[destName] = true
          end)
      end
      
      if subevent == "SPELL_CAST_SUCCESS" and spellID == aura_env.essence then
          aura_env.count = aura_env.count+1
      end
      
      if subevent == "SPELL_AURA_APPLIED" then
          
          if  
          (aura_env.type[aura_env.count] == "Void" and spellID == aura_env.spells["Void"]) or
          (aura_env.type[aura_env.count] == "Vita" and spellID == aura_env.debuffs["Vita"] and aura_env.go) or
          (aura_env.type[aura_env.count] == "Nightmare" and spellID == aura_env.debuffs["Nightmare"] and aura_env.go)then
              aura_env.go = false
              aura_env.starttime = GetTime()
              aura_env.alerted = false
              aura_env.notify_alerted = false
              aura_env.assigned = {}
              aura_env.one = {}
              
              if aura_env.type[aura_env.count] ~= "Void" then
                  for unit in WA_IterateGroupMembers() do
                      if WA_GetUnitAura(unit, aura_env.debuffs[aura_env.type[aura_env.count]], aura_env.debug) and not aura_env.one[1] then
                          aura_env.one[1] = UnitName(unit)
                          aura_env.assigned[aura_env.one[1]] = true
                          break
                      end
                  end
              end
              
              for i=1, #aura_env.team do
                  if not UnitIsDead(aura_env.team[i]) 
                  and not WA_GetUnitAura(aura_env.team[i], aura_env.debuffs["Vita"], aura_env.debug) 
                  and not WA_GetUnitAura(aura_env.team[i], aura_env.debuffs["Nightmare"], aura_env.debug)
                  and not aura_env.assigned[aura_env.team[i]] then
                      if WA_GetUnitAura(aura_env.team[i], aura_env.vuln, aura_env.debug) then
                          local expires = select(6, WA_GetUnitAura(aura_env.team[i], aura_env.vuln, aura_env.debug))
                          if Round(expires-GetTime()) < i*aura_env.cycle then
                              aura_env.one[#aura_env.one+1] = aura_env.team[i]
                              aura_env.assigned[aura_env.team[i]] = true
                              if UnitIsUnit(aura_env.team[i], "player") then
                                  aura_env.number = true
                              end
                              aura_env.number_backup = true
                          else
                              for j=1, #aura_env.backup do
                                  if not UnitIsDead(aura_env.backup[j]) 
                                  and not WA_GetUnitAura(aura_env.backup[j], aura_env.debuffs["Vita"], aura_env.debug) 
                                  and not WA_GetUnitAura(aura_env.backup[j], aura_env.debuffs["Nightmare"], aura_env.debug) 
                                  and not aura_env.assigned[aura_env.backup[j]]
                                  then
                                      if WA_GetUnitAura(aura_env.backup[j], aura_env.vuln, aura_env.debug) then
                                          local expires = select(6, WA_GetUnitAura(aura_env.backup[j], aura_env.vuln, aura_env.debug))
                                          if Round(expires-GetTime()) < i*aura_env.cycle then
                                              aura_env.assigned[aura_env.backup[j]] = true
                                              aura_env.one[#aura_env.one+1] = aura_env.backup[j]
                                              if UnitIsUnit(aura_env.backup[j], "player") then
                                                  WeakAuras.ScanEvents("NS_RADEN_BACKUP", i+1, aura_env.type[count])
                                                  aura_env.number = true
                                              end
                                              WeakAuras.ScanEvents("NS_RADEN_BACKUP_NOTIFY", i, aura_env.type[aura_env.count], aura_env.backup[j])
                                              aura_env.number_backup = true
                                              break
                                          end
                                      else
                                          aura_env.assigned[aura_env.backup[j]] = true
                                          aura_env.one[#aura_env.one+1] = aura_env.backup[j]
                                          if UnitIsUnit(aura_env.backup[j], "player") then
                                              WeakAuras.ScanEvents("NS_RADEN_BACKUP", i+1, aura_env.type[count])
                                              aura_env.number = true
                                          end
                                          WeakAuras.ScanEvents("NS_RADEN_BACKUP_NOTIFY", i, aura_env.type[aura_env.count], aura_env.backup[j])
                                          aura_env.number_backup = true
                                          break
                                      end
                                  end
                              end
                          end
                      else
                          aura_env.one[#aura_env.one+1] = aura_env.team[i]
                          aura_env.assigned[aura_env.team[i]] = true
                          if UnitIsUnit(aura_env.team[i], "player") then
                              aura_env.number = true
                          end
                          aura_env.number_backup = true
                      end
                  else
                      for j=1, #aura_env.backup do
                          if not UnitIsDead(aura_env.backup[j]) 
                          and not WA_GetUnitAura(aura_env.backup[j], aura_env.debuffs["Vita"], aura_env.debug) 
                          and not WA_GetUnitAura(aura_env.backup[j], aura_env.debuffs["Nightmare"], aura_env.debug) 
                          and not aura_env.assigned[aura_env.backup[j]]
                          then
                              if WA_GetUnitAura(aura_env.backup[j], aura_env.vuln, aura_env.debug) then
                                  local expires = select(6, WA_GetUnitAura(aura_env.backup[j], aura_env.vuln, aura_env.debug))
                                  if Round(expires-GetTime()) < i*aura_env.cycle then
                                      aura_env.assigned[aura_env.backup[j]] = true
                                      aura_env.one[#aura_env.one+1] = aura_env.backup[j]
                                      if UnitIsUnit(aura_env.backup[j], "player") then
                                          WeakAuras.ScanEvents("NS_RADEN_BACKUP", i+1, aura_env.type[count])
                                          aura_env.number = true
                                      end
                                      WeakAuras.ScanEvents("NS_RADEN_BACKUP_NOTIFY", i, aura_env.type[aura_env.count], aura_env.backup[j])
                                      aura_env.number_backup = true
                                      break
                                  end
                              else
                                  aura_env.assigned[aura_env.backup[j]] = true
                                  aura_env.one[#aura_env.one+1] = aura_env.backup[j]
                                  if UnitIsUnit(aura_env.backup[j], "player") then
                                      WeakAuras.ScanEvents("NS_RADEN_BACKUP", i+1, aura_env.type[count])
                                      aura_env.number = true
                                  end
                                  WeakAuras.ScanEvents("NS_RADEN_BACKUP_NOTIFY", i, aura_env.type[aura_env.count], aura_env.backup[j])
                                  aura_env.number_backup = true
                                  break
                              end
                          end 
                      end
                  end
              end
              
              return true
              
          elseif (aura_env.type[aura_env.count] == "Vita" and spellID == aura_env.spells["Vita"]) or (aura_env.type[aura_env.count] == "Nightmare" and spellID == aura_env.spells["Nightmare"]) then
              aura_env.go = true
              if spellID == aura_env.spells["Vita"] then
                  aura_env.vitacount = aura_env.vitacount+1
                  if aura_env.vitacount > 2 then
                      aura_env.vitacount = 1
                  end
              end
          end
      end
      
      if aura_env.config["debug"] and subevent == "SPELL_CAST_SUCCESS" and spellID == 18562 then -- swiftmend
          aura_env.vulnerable = {}
          aura_env.count = 0
          aura_env.ERT()
      end
      
  end
  
  if event == "ENCOUNTER_START" then
      aura_env.count = 0
      aura_env.vitacount = 0
      aura_env.vulnerable = {}
      aura_env.ERT()
  end
end


aura_lose_effect = function(event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestampe, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellschool, extraspellID, extraspellName  = ...
        
        if subevent == "SPELL_AURA_REMOVED" and aura_env.spells[aura_env.type[aura_env.count]] == spellID then
            aura_env.assigned = {}
            aura_env.one = {}
            aura_env.vulnerable = {}
            aura_env.alerted = false
            aura_env.notify_alerted = false
            aura_env.number = false
            aura_env.number_backup = false
            aura_env.starttime = 0
            return true
        end
        
        --[[      if aura_env.config["debug"] and subevent == "SPELL_CAST_SUCCESS" and spellID == 22812 then -- Barkskin
            aura_env.assigned = {}
            aura_env.one = {}
            aura_env.vulnerable = {}
            aura_env.alerted = false
            aura_env.notify_alerted = false
            aura_env.number = false
            aura_env.number_backup = false
            aura_env.count = 0
            aura_env.starttime = 0
            return true
        end]]
        
        
        
    end
    if event == "ENCOUNTER_END" then
        aura_env.assigned = {}
        aura_env.one = {}
        aura_env.vulnerable = {}
        aura_env.alerted = false
        aura_env.notify_alerted = false
        aura_env.number = false
        aura_env.number_backup = false
        aura_env.count = 0
        aura_env.starttime = 0
        return true
    end
end
