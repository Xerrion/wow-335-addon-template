local Addon = unpack(select(2, ...))
local L = Addon.Libs.Locale:NewLocale(Addon.Name, "enUS", true)

-- Addon related strings
L["ADDON_LOADED"] = Addon.Name .. " has been loaded."

-- Frame related strings
L["FRAME_TITLE"] = Addon.Name .. " Frame"
L["FRAME_STATUS"] = Addon.Name .. " example frame created."

-- Event related strings
L["PLAYER_HEALTH_CHANGED"] = "Player health changed."