--[[
Core\Frames.lua
Manages the creation and interaction of GUI frames using AceGUI.
This module provides utilities for creating and handling addon-specific frames.
]]

local Addon, Locale, Profile = unpack(select(2, ...)) -- Unpack the Engine components
local GUI = Addon.Libs.GUI -- Reference to AceGUI library

-- Tracks whether the main frame is currently shown
local main_frame_shown = false

-- Callback to close and release a frame
-- @param frame (AceGUI Frame): The frame to be released.
function CloseFrame(frame)
    if frame then
        GUI:Release(frame) -- Release resources associated with the frame
    end
end

-- Creates a generic GUI frame with a title and optional status text
-- @param title (string): The title of the frame.
-- @param status (string, optional): The status text to display at the bottom of the frame.
-- @return (AceGUI Frame): The created frame.
local function CreateFrame(title, status)
    if main_frame_shown then return end -- Exit if the frame is already shown
    local frame = GUI:Create("Frame") -- Create a new frame
    frame:SetTitle(title) -- Set the frame's title

    if status then
        frame:SetStatusText(status) -- Set optional status text
    end

    -- Attach the `OnClose` callback to release the frame when it is closed
    frame:SetCallback("OnClose", function(widget)
        CloseFrame(widget)
        main_frame_shown = false
    end)

    return frame
end

-- Displays the main frame
-- Prevents creating multiple instances of the main frame by checking `main_frame_shown`.
local function MainFrame()
    if main_frame_shown then return end -- Exit if the frame is already shown

    -- Create the frame with localized title and status text
    CreateFrame(Locale["FRAME_TITLE"], Locale["FRAME_STATUS"])
    main_frame_shown = true -- Mark the frame as shown
end

-- Command to show the main frame
-- This function is linked to a chat command in the Commands module.
function Addon:ShowFrameCommand()
    MainFrame()
end
