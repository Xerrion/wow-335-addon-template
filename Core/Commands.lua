--[[
Core\Commands.lua
Registers and handles chat commands using AceConsole.
]]

local Addon, Locale, Profile = unpack(select(2, ...))

-- Register the slash command
Addon:RegisterChatCommand(Addon.SlashCommand, "SlashHandler")

-- Handles slash commands
-- @param input (string): The command input string.
function Addon:SlashHandler(input)
    switch(input and input:trim()) {
        ["debug"] = function()
            local debug_mode = not self:GetDebugMode()
            self:SetDebugMode(debug_mode)
            self.Logging:Info(Locale["Debug mode:"] .. " " .. (debug_mode and Locale["ON"] or Locale["OFF"]))
        end,

        ["options"] = function()
            self:ShowOptionsDialog()
        end,

        __index = function()
            self:ShowFrameCommand()
        end
    }
end
