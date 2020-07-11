local r = aura_env.region

if not r.tickPool then
    r.tickPool = CreateTexturePool(r.bar, "OVERLAY", 7, nil) 
end

r.tickPool:ReleaseAll();

aura_env.Acquire = function()
    local tick = r.tickPool:Acquire()
    tick:SetDrawLayer("ARTWORK", 3);
    tick:SetColorTexture(0, 0, 0, 1)
    tick:SetWidth(2);
    tick:SetHeight(r.height);
    return tick
end

aura_env.show = function()
    aura_env.region.tickPool:ReleaseAll()
    local tick = aura_env.Acquire()
    
    tick:ClearAllPoints()
    tick:SetPoint("CENTER", aura_env.region.bar, "CENTER")
    tick:Show()
end


