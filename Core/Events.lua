local Addon, Locale, Profile = unpack(select(2, ...))

function Addon:UpdateHealthEvent(units)
    if units.player then
      Addon.Logging.Info(Locale["PLAYER_HEALTH_CHANGED"])
    end
  end