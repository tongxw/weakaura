function()
  if WeakAuras.IsOptionsOpen() then
      return "Ra-den Test Position"
  end
  aura_env.message = aura_env.message or ""
  return aura_env.message
end
