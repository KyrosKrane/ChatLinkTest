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
	local Link, ReturnedCallbackID = ChatLink:CreateChatLink(DisplayText, Data, SkipFormat, CallbackID, PublicMessageID)

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
end -- GenerateTC()


--#########################################
--# Test cases
--#########################################

GenerateTC("HandleClick", "Test case 1: Basic link with display text only")
GenerateTC("SecondHandleClick", "Test case 2: Alternate click handler")
GenerateTC("HandleClick", "Test case 3: Link with data", "12.3, 45.6")

-- Create a formatted link for testing the SkipFormat parameter
local TestCase4 = WrapTextInColorCode(">>Test case 4: Link with custom formatting, no data<<", "FF00FF00")
GenerateTC("HandleClick", TestCase4, nil, true)

local TestCase5 = WrapTextInColorCode(">>Test case 5: Link with custom formatting, with data<<", "FF00FF00")
GenerateTC("HandleClick", TestCase5, "apple banana", true)

GenerateTC("HandleClick", "Test case 6: Link with custom callback ID", nil, nil, "CLT-Callback-Test6")
GenerateTC("HandleClick", "Test case 7: Link with data and custom callback ID", "cherry", nil, "CLT-Callback-Test7")
local TestCase8 = WrapTextInColorCode(">>Test case 8: Link with skipformat and custom callback ID<<", "FF00FF00")
GenerateTC("HandleClick", TestCase8, nil, true, "CLT-Callback-Test8")
local TestCase9 = WrapTextInColorCode(">>Test case 9: Link with data, skipformat, and custom callback ID<<", "FF00FF00")
GenerateTC("HandleClick", TestCase9, "cherry", true, "CLT-Callback-Test9")

