--[[
Init.lua
This file initializes the addon, setting up core components and ensuring dependencies are loaded.
It uses Ace3 to provide modularity and supports event handling, console commands, and more.

Main Variables:
- ADDON_NAME: The name of the addon.
- Engine: A table containing core components of the addon.
]]
local AceAddon, _ = LibStub("AceAddon-3.0")
local CallbackHandler = LibStub("CallbackHandler-1.0")

local AddOnName, Engine = ...
local AddOn = AceAddon:NewAddon(AddOnName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0",
    "AceSerializer-3.0")

-- Error out if the addon fails to initialize
if not AddOn then
    error("Failed to initialize addon.")
end

-- Core addon setup
AddOn.Name = AddOnName
AddOn.Callbacks = AddOn.callbacks or CallbackHandler:New(AddOn)
AddOn.DF = {
    profile = {
        debug_mode = false -- Default debug mode state
    }
}

-- Options table for AceConfig
AddOn.Options = { type = "group", name = AddOnName, args = {} }

-- Register the slash command
AddOn.SlashCommand = AddOnName

-- Libraries used by the addon
AddOn.Libs = {
    Database = LibStub("AceDB-3.0"),
    Locale = LibStub("AceLocale-3.0"),
    GUI = LibStub("AceGUI-3.0"),
    Config = LibStub("AceConfig-3.0"),
    ConfigDialog = LibStub("AceConfigDialog-3.0")
}

-- Logging module
AddOn.Logging = {
    Info = function(msg) AddOn:Print(msg) end,
    Warn = function(msg) AddOn:Print("|cffff0000" .. msg .. "|r") end,
    Error = function(msg) AddOn:Print("|cffff0000" .. msg .. "|r") end,
    Debug = function(msg) if AddOn.DF.profile.debug_mode then AddOn:Print(msg) end end
}

-- Assign engine components
Engine[1] = AddOn            -- Main addon object
Engine[2] = {}               -- Locale object
Engine[3] = AddOn.DF.profile -- Default profile
_G[AddOnName] = Engine       -- Global access to the addon

-- OnInitialize lifecycle event
function AddOn:OnInitialize()
    -- Initialize components
    self:Initialize()
end
