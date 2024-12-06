--[[
Core\Options.lua
Handles the creation and management of configuration options using AceConfig.

Main Functions:
- Addon:GetDebugMode(): Returns the current debug mode state.
- Addon:SetDebugMode(mode): Sets the debug mode state.
- Addon:CreateOptionsTable(): Creates the configuration options table.
- Addon:ShowOptionsDialog(): Opens the options dialog in the UI.
- Addon:CloseOptionsDialog(): Closes the options dialog.
]]

local Addon, Locale, Profile = unpack(select(2, ...))
local ADDON_NAME = Addon.Name

-- Returns the current debug mode state
function Addon:GetDebugMode()
    -- Ensure debug_mode is initialized
    if Profile.debug_mode == nil then
        Profile.debug_mode = self.DF.profile.debug_mode
    end
    return Profile.debug_mode
end

-- Sets the debug mode state
-- @param mode (boolean): True to enable debug mode, false to disable.
function Addon:SetDebugMode(mode)
    if type(mode) ~= "boolean" then
        self:Print("Mode must be true/false")
        return
    end
    Profile.debug_mode = mode
end

-- Creates and registers the options table for the addon
-- @return (table): The options table.
function Addon:CreateOptionsTable()
    local options = {
        handler = self,
        type = "group",
        args = {
            general = {
                name = "General",
                type = "group",
                args = {
                    debug_mode = {
                        name = "Debug Mode",
                        desc = "Enable debug mode",
                        type = "toggle",
                        get = function() return self:GetDebugMode() end,
                        set = function(_, val) self:SetDebugMode(val) end
                    }
                }
            }
        }
    }

    -- Add profiles support
    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.data)

    -- Register the options table
    Addon.Libs.Config:RegisterOptionsTable(ADDON_NAME, options)
    return options
end

-- Opens the options dialog
function Addon:ShowOptionsDialog()
    Addon.Libs.ConfigDialog:Open(ADDON_NAME)
end

-- Closes the options dialog
function Addon:CloseOptionsDialog()
    Addon.Libs.ConfigDialog:Close(ADDON_NAME)
end
