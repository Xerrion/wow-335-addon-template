--[[
Core\Core.lua
This is the main addon file responsible for initializing the addon, setting up the locale, and establishing
the core components such as saved variables and options. It utilizes Ace3 for functionality.
]]

-- Initialize the Engine table from the global addon scope
local Engine = select(2, ...)

-- Localize the game locale
local gameLocale
do
    -- Locale fallback table
    local convert = {
        ["enGB"] = "enUS", -- Treat British English as US English
        ["esES"] = "esMX", -- Treat European Spanish as Latin American Spanish
        ["itIT"] = "enUS"  -- Treat Italian as US English
    }

    -- Get the player's game locale
    local lang = GetLocale()

    -- Use the converted or original locale, defaulting to "enUS" if unavailable
    gameLocale = convert[lang] or lang or "enUS"

    -- Register the locale with the addon's locale library
    Engine[2] = Engine[1].Libs.Locale:GetLocale(Engine[1].Name, gameLocale)
end

-- Unpack the Engine to access the Addon, Locale, and Profile objects
local Addon, Locale, Profile = unpack(Engine)

-- Initializes the addon and its core components
-- This function is called during the `OnInitialize` lifecycle event
function Addon:Initialize()
    -- Store the player's unique identifier
    self.myguid = UnitGUID("player")

    -- Initialize saved variables using AceDB-3.0
    -- @param Addon.Name .. "DB": Name of the database saved variable
    -- @param self.DF: Default profile data structure
    self.data = Addon.Libs.Database:New(Addon.Name .. "DB", self.DF)

    -- Store the current profile in the addon object for quick access
    self.db = self.data.profile

    -- Create the options table for configuration settings
    self.options = self:CreateOptionsTable()

    -- Log a message indicating that the addon has successfully loaded
    Addon.Logging:Info(Locale["ADDON_LOADED"])
end
