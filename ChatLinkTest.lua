-- ChatLinkTest.lua
-- Written by KyrosKrane Sylvanblade (kyros@kyros.info)
-- Copyright (c) 2021 KyrosKrane Sylvanblade
-- Licensed under the MIT License, as per the included file.
-- Addon version: @project-version@

--#########################################
--# Description
--#########################################

-- This add-on file creates some test cases for the ChatLink-1.0 library

local addonName, CLT = ...


function CLT:HandleClick(CallbackID, DisplayText, Data)
	DEFAULT_CHAT_FRAME:AddMessage("HandleClick called with parameters:")
	DEFAULT_CHAT_FRAME:AddMessage("    CallbackID = >>" .. CallbackID .. "<<")
	DEFAULT_CHAT_FRAME:AddMessage("    DisplayText = >>" .. DisplayText .. "<<")
	DEFAULT_CHAT_FRAME:AddMessage("    Data = >>" .. Data .. "<<")
end



local ChatLink = LibStub("ChatLink-1.0")
local DisplayText = "click this link"
local Link, CallbackID = ChatLink:CreateChatLink(DisplayText)
if CallbackID then
	ChatLink.RegisterCallback(CLT, CallbackID, "HandleClick")
else
	DEFAULT_CHAT_FRAME:AddMessage("CreateChatLink() FAILED. CallbackID nil or false.")
end

if Link then
	DEFAULT_CHAT_FRAME:AddMessage("This is a test of the ChatLink library. You can " .. Link .. " to run the test.")
else
	DEFAULT_CHAT_FRAME:AddMessage("CreateChatLink() FAILED. Link nil or false.")
end
