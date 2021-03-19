-- ChatLinkTest.lua
-- Written by KyrosKrane Sylvanblade (kyros@kyros.info)
-- Copyright (c) 2021 KyrosKrane Sylvanblade
-- Licensed under the MIT License, as per the included file.
-- Addon version: @project-version@

--#########################################
--# Description
--#########################################

-- This add-on file creates some test cases for the ChatLink-1.0 library


--#########################################
--# Setup
--#########################################

local addonName, CLT = ...
local ChatLink = LibStub("ChatLink-1.0")

--#########################################
--# Click handling
--#########################################

-- Note that since we don't actually do anything with the data, one function is enough for all test cases.
-- We only create a second to ensure callbacks are calling the right function.

function CLT:HandleClick(CallbackID, DisplayText, Data)
	DEFAULT_CHAT_FRAME:AddMessage("HandleClick called with parameters:")
	DEFAULT_CHAT_FRAME:AddMessage("    CallbackID = >>" .. CallbackID .. "<<")
	DEFAULT_CHAT_FRAME:AddMessage("    DisplayText = >>" .. DisplayText .. "<<")
	DEFAULT_CHAT_FRAME:AddMessage("    Data = >>" .. Data .. "<<")
end

function CLT:SecondHandleClick(One, Two, Three)
	DEFAULT_CHAT_FRAME:AddMessage("SecondHandleClick called with parameters:")
	DEFAULT_CHAT_FRAME:AddMessage("    CallbackID = >>" .. One .. "<<")
	DEFAULT_CHAT_FRAME:AddMessage("    DisplayText = >>" .. Two .. "<<")
	DEFAULT_CHAT_FRAME:AddMessage("    Data = >>" .. Three .. "<<")
end


--#########################################
--# Test case link generator
--#########################################

-- This function generates a test case link.
-- The first parameter is the callback function name to handle the click.
-- The next five parameters are used to create the link.

local function GenerateTC(Handler, DisplayText, Data, SkipFormat, CallbackID, PublicMessageID)
	-- create link
	local Link, ReturnedCallbackID = ChatLink:CreateChatLink(DisplayText)

	-- verify successful creation
	if not ReturnedCallbackID then
		DEFAULT_CHAT_FRAME:AddMessage("CreateChatLink() FAILED for " .. DisplayText .. ". CallbackID nil or false.")
	end
	if not Link then
		DEFAULT_CHAT_FRAME:AddMessage("CreateChatLink() FAILED for " .. DisplayText .. ". Link nil or false.")
	end
	if not ReturnedCallbackID or not Link then return end

	-- Register to handle the click event
	ChatLink.RegisterCallback(CLT, ReturnedCallbackID, Handler)

	-- Display the test case
	DEFAULT_CHAT_FRAME:AddMessage("Click this link for " .. Link .. ".")
end


--#########################################
--# Test cases
--#########################################

GenerateTC("HandleClick", "Test case 1: Basic link with display text only")
GenerateTC("SecondHandleClick", "Test case 2: Alternate click handler")
