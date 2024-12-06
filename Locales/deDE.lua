local Addon = unpack(select(2, ...))
local L = Addon.Libs.Locale:NewLocale(Addon.Name, "deDE")

-- Addon related strings
L["ADDON_LOADED"] = Addon.Name .. " wurde geladen."

-- Frame related strings
L["FRAME_TITLE"] = Addon.Name .. " Rahmen"
L["FRAME_STATUS"] = Addon.Name .. " Beispiel Rahmen erstellt."

-- Event related strings
L["PLAYER_HEALTH_CHANGED"] = "Spieler Gesundheit geändert."