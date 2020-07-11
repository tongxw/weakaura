aura_env.GetFrame = WeakAuras.GetUnitFrame


-- Custom Glow

local LCG = LibStub("LibCustomGlow-1.0")
local glowTypes = {"Standard","Pixel","AutoCast"}
local glowType = glowTypes[aura_env.config.glowType]

aura_env.Glow = function(frame,show)
    if show then
        if glowType == "AutoCast" then
            LCG.AutoCastGlow_Start(
                frame,
                aura_env.config.glowColor,
                aura_env.config.glowParticules,
                aura_env.config.glowFrequency,
                aura_env.config.glowScale,
                aura_env.config.glowxOffset,
                aura_env.config.glowyOffset,
                aura_env.id
            )
        elseif glowType == "Pixel" then
            LCG.PixelGlow_Start(
                frame,
                aura_env.config.glowColor,
                aura_env.config.glowParticules,
                aura_env.config.glowFrequency,
                aura_env.config.glowLength,
                aura_env.config.glowThickness,
                aura_env.config.glowxOffset,
                aura_env.config.glowyOffset,
                aura_env.config.glowBorder,
                aura_env.id
            )
        elseif glowType == "Standard" then
            LCG.ButtonGlow_Start(
                frame,
                aura_env.config.glowColor,
                aura_env.config.glowFrequency
            )
        end
    else
        if glowType == "AutoCast" then
            LCG.AutoCastGlow_Stop(frame, aura_env.id)
        elseif glowType == "Pixel" then
            LCG.PixelGlow_Stop(frame, aura_env.id)
        elseif glowType == "Standard" then
            LCG.ButtonGlow_Stop(frame)
        end
    end
end

