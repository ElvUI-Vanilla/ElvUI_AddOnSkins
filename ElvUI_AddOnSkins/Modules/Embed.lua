local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EMB = E:NewModule("EmbedSystem");
local AS = E:GetModule("AddOnSkins");

--Cache global variables
--Lua functions
local _G = _G
local pairs, tonumber = pairs, tonumber
local floor = math.floor
local format, lower, match = string.format, string.lower, string.match
local tinsert = table.insert
--WoW API / Variables
local hooksecurefunc = hooksecurefunc
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS

function EMB:GetChatWindowInfo()
	local chatTabInfo = {[NONE] = NONE}
	for i = 1, NUM_CHAT_WINDOWS do
		chatTabInfo["ChatFrame"..i] = _G["ChatFrame"..i.."Tab"]:GetText()
	end
	return chatTabInfo
end

function EMB:ToggleChatFrame(hide)
	local chatFrame = E.db.addOnSkins.embed.hideChat
	if chatFrame == NONE then return end

	if hide then
		_G[chatFrame].originalParent = _G[chatFrame]:GetParent()
		_G[chatFrame]:SetParent(E.HiddenFrame)

		_G[chatFrame.."Tab"].originalParent = _G[chatFrame.."Tab"]:GetParent()
		_G[chatFrame.."Tab"]:SetParent(E.HiddenFrame)
	else
		if _G[chatFrame].originalParent then
			_G[chatFrame]:SetParent(_G[chatFrame].originalParent)
			_G[chatFrame.."Tab"]:SetParent(_G[chatFrame.."Tab"].originalParent)
		end
	end
end

function EMB:EmbedShow()
	if _G[self.leftFrame.frameName] then
		_G[self.leftFrame.frameName]:Show()
	end

	if E.db.addOnSkins.embed.embedType == "DOUBLE" then
		if _G[self.rightFrame.frameName] then
			_G[self.rightFrame.frameName]:Show()
		end
	end

	self:ToggleChatFrame(true)
	self.switchButton:SetAlpha(1)
end

function EMB:EmbedHide()
	if _G[self.leftFrame.frameName] then
		_G[self.leftFrame.frameName]:Hide()
	end

	if E.db.addOnSkins.embed.embedType == "DOUBLE" then
		if _G[self.rightFrame.frameName] then
			_G[self.rightFrame.frameName]:Hide()
		end
	end

	self:ToggleChatFrame(false)
	self.switchButton:SetAlpha(0.6)
end

function EMB:CheckEmbed(addon)
	local db = E.db.addOnSkins.embed
	local left, right, embed = lower(db.leftWindow), lower(db.rightWindow), lower(addon)

	if AS:CheckAddOn(addon) and ((db.embedType == "SINGLE" and match(left, embed)) or db.embedType == "DOUBLE" and (match(left, embed) or match(right, embed))) then
		return true
	else
		return false
	end
end

function EMB:EmbedUpdate()
	if E.db.addOnSkins.embed.embedType == "DISABLE" then return end

	if not self.embedCreated then
		self:EmbedCreate()
	end

	self:WindowResize()

	if self:CheckEmbed("KLHThreatMeter") then self:EmbedKLHThreatMeter() end
	if self:CheckEmbed("DPSMate") then self:EmbedDPSMate() end
end

function EMB:SetHooks()
	hooksecurefunc(E:GetModule("Chat"), "PositionChat", function(self, override)
		if override then
			EMB:EmbedUpdate()
		end
	end)
	hooksecurefunc(E:GetModule("Layout"), "ToggleChatPanels", function() EMB:EmbedUpdate() end)

	hooksecurefunc(LeftChatPanel, "fadeFunc", function()
		LeftChatPanel:Hide()
		if not E.db.addOnSkins.embed.rightChatPanel then
			EMB.switchButton:Hide()
		end
	end)
	hooksecurefunc(RightChatPanel, "fadeFunc", function()
		RightChatPanel:Hide()
		if E.db.addOnSkins.embed.rightChatPanel then
			EMB.switchButton:Hide()
		end
	end)

	RightChatToggleButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	RightChatToggleButton:SetScript("OnClick", function()
		if arg1 == "RightButton" then
			if E.db.addOnSkins.embed.rightChatPanel then
				if EMB.mainFrame:IsShown() then
					EMB.mainFrame:Hide()
				else
					EMB.mainFrame:Show()
				end
			end
		else
			if E.db[this.parent:GetName().."Faded"] then
				E.db[this.parent:GetName().."Faded"] = nil
				UIFrameFadeIn(this.parent, 0.2, this.parent:GetAlpha(), 1)
				UIFrameFadeIn(this, 0.2, this:GetAlpha(), 1)
			else
				E.db[this.parent:GetName().."Faded"] = true
				UIFrameFadeOut(this.parent, 0.2, this.parent:GetAlpha(), 0)
				UIFrameFadeOut(this, 0.2, this:GetAlpha(), 0)
				this.parent.fadeInfo.finishedFunc = this.parent.fadeFunc
			end
		end
		EMB:UpdateSwitchButton()
	end)

	HookScript(RightChatToggleButton, "OnEnter", function()
		if E.db.addOnSkins.embed.rightChatPanel then
			GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Embedded Addon"], 1, 1, 1)
			GameTooltip:Show()
			EMB:UpdateSwitchButton()
		end
	end)

	LeftChatToggleButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	LeftChatToggleButton:SetScript("OnClick", function()
		if arg1 == "RightButton" then
			if not E.db.addOnSkins.embed.rightChatPanel then
				if EMB.mainFrame:IsShown() then
					EMB.mainFrame:Hide()
				else
					EMB.mainFrame:Show()
				end
			end
		else
			if E.db[this.parent:GetName().."Faded"] then
				E.db[this.parent:GetName().."Faded"] = nil
				UIFrameFadeIn(this.parent, 0.2, this.parent:GetAlpha(), 1)
				UIFrameFadeIn(this, 0.2, this:GetAlpha(), 1)
			else
				E.db[this.parent:GetName().."Faded"] = true
				UIFrameFadeOut(this.parent, 0.2, this.parent:GetAlpha(), 0)
				UIFrameFadeOut(this, 0.2, this:GetAlpha(), 0)
				this.parent.fadeInfo.finishedFunc = this.parent.fadeFunc
			end
		end
		EMB:UpdateSwitchButton()
	end)

	HookScript(LeftChatToggleButton, "OnEnter", function()
		if not E.db.addOnSkins.embed.rightChatPanel then
			GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Embedded Addon"], 1, 1, 1)
			GameTooltip:Show()
			EMB:UpdateSwitchButton()
		end
	end)

	function HideLeftChat()
		LeftChatToggleButton:Click()
	end

	function HideRightChat()
		RightChatToggleButton:Click()
	end

	function HideBothChat()
		LeftChatToggleButton:Click()
		RightChatToggleButton:Click()
	end
end

function EMB:WindowResize()
	if not self.embedCreated then return end

	local db = E.db.addOnSkins.embed
	local SPACING = E.Border + E.Spacing
	local chatPanel = db.rightChatPanel and RightChatPanel or LeftChatPanel
	local chatTab = db.rightChatPanel and RightChatTab or LeftChatTab
	local chatData = db.rightChatPanel and RightChatDataPanel or LeftChatToggleButton
	local topRight = chatData == RightChatDataPanel and (E.db.datatexts.rightChatPanel and "TOPLEFT" or "BOTTOMLEFT") or chatData == LeftChatToggleButton and (E.db.datatexts.leftChatPanel and "TOPLEFT" or "BOTTOMLEFT")
	local yOffset = (chatData == RightChatDataPanel and E.db.datatexts.rightChatPanel and SPACING) or (chatData == LeftChatToggleButton and E.db.datatexts.leftChatPanel and SPACING) or 0
	local xOffset = (E.db.chat.panelBackdrop == "RIGHT" and db.rightChatPanel and 0) or (E.db.chat.panelBackdrop == "LEFT" and not db.rightChatPanel and 0) or (E.db.chat.panelBackdrop == "SHOWBOTH" and 0) or E.Border*3 - E.Spacing
	local isDouble = db.embedType == "DOUBLE"

	self.mainFrame:SetParent(chatPanel)
	self.mainFrame:ClearAllPoints()

	E:Point(self.mainFrame, "BOTTOMLEFT", chatData, topRight, 0, yOffset)
	E:Point(self.mainFrame, "TOPRIGHT", chatTab, db.belowTopTab and "BOTTOMRIGHT" or "TOPRIGHT", xOffset, db.belowTopTab and -SPACING or 0)

	-- Ensure that the embed-frame is always rendered *above* the chatwindow text to avoid clipping.
	-- NOTE: "SetFrameStrata" MUST be executed AFTER the "SetParent" call (above), since re-parenting always inherits parent's strata!
	self.mainFrame:SetFrameStrata("MEDIUM")

	if isDouble then
		self.leftFrame:ClearAllPoints()
		E:Point(self.leftFrame, "TOPLEFT", self.mainFrame)
		E:Point(self.leftFrame, "BOTTOMRIGHT", self.mainFrame, "BOTTOMRIGHT", -(self.mainFrame:GetWidth() - db.leftWindowWidth + SPACING), 0)

		self.rightFrame:ClearAllPoints()
		E:Point(self.rightFrame, "TOPLEFT", self.leftFrame, "TOPRIGHT", SPACING, 0)
		E:Point(self.rightFrame, "BOTTOMRIGHT", self.mainFrame)
	else
		self.leftFrame:ClearAllPoints()
		E:Point(self.leftFrame, "TOPLEFT", self.mainFrame)
		E:Point(self.leftFrame, "BOTTOMRIGHT", self.mainFrame)
	end

	self:UpdateSwitchButton()

	if IsAddOnLoaded("ElvUI_Config") then
		E.Options.args.elvuiPlugins.args.addOnSkins.args.embed.args.leftWindowWidth.min = floor(chatPanel:GetWidth() * .25)
		E.Options.args.elvuiPlugins.args.addOnSkins.args.embed.args.leftWindowWidth.max = floor(chatPanel:GetWidth() * .75)
	end
end

function EMB:UpdateSwitchButton()
	local db = E.db.addOnSkins.embed
	local chatPanel = db.rightChatPanel and RightChatPanel or LeftChatPanel
	local chatTab = db.rightChatPanel and RightChatTab or LeftChatTab
	local isDouble = db.embedType == "DOUBLE"

	self.switchButton:SetParent(chatPanel)

	if db.belowTopTab and chatPanel:IsShown() then
		self.switchButton:Show()
		self.switchButton.text:SetText(isDouble and db.leftWindow.." / "..db.rightWindow or db.leftWindow)
		self.switchButton:ClearAllPoints()

		if E.Chat.RightChatWindowID and _G["ChatFrame"..E.Chat.RightChatWindowID.."Tab"]:IsVisible() then
			E:Point(self.switchButton, "LEFT", _G["ChatFrame"..E.Chat.RightChatWindowID.."Tab"], "RIGHT", 0, 0)
		else
			E:Point(self.switchButton, db.rightChatPanel and "LEFT" or "RIGHT", chatTab, 5, 4)
		end
	elseif self.switchButton:IsShown() then
		self.switchButton:Hide()
	end
end

function EMB:EmbedCreate()
	if self.embedCreated then return end

	self.mainFrame = CreateFrame("Frame", "ElvUI_AddOnSkins_Embed_MainWindow", UIParent)
	self.leftFrame = CreateFrame("Frame", "ElvUI_AddOnSkins_Embed_LeftWindow", self.mainFrame)
	self.rightFrame = CreateFrame("Frame", "ElvUI_AddOnSkins_Embed_RightWindow", self.mainFrame)

	self.switchButton = CreateFrame("Button", "ElvUI_AddOnSkins_Embed_SwitchButton", UIParent)
	E:Size(self.switchButton, 120, 32)
	self.switchButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	self.switchButton.text = self.switchButton:CreateFontString(nil, "OVERLAY")
	E:FontTemplate(self.switchButton.text, E.LSM:Fetch("font", E.db.chat.tabFont), E.db.chat.tabFontSize, E.db.chat.tabFontOutline)
	self.switchButton.text:SetTextColor(unpack(E["media"].rgbvaluecolor))
	E:Point(self.switchButton.text, "LEFT", 16, -5)

	self.switchButton:SetScript("OnClick", function()
		if EMB.mainFrame:IsShown() then
			EMB.mainFrame:Hide()
			this:SetAlpha(0.6)
		else
			EMB.mainFrame:Show()
			this:SetAlpha(1)
		end
		EMB:UpdateSwitchButton()
	end)

	self.switchButton:SetScript("OnMouseDown", function() E:Point(this.text, "LEFT", 18, -7) end)
	self.switchButton:SetScript("OnMouseUp", function() E:Point(this.text, "LEFT", 16, -5) end)

	self.mainFrame:SetScript("OnShow", function() EMB:EmbedShow() end)
	self.mainFrame:SetScript("OnHide", function() EMB:EmbedHide() end)

	self.embedCreated = true

	self:SetHooks()
	self:ToggleChatFrame(false)
	self:EmbedUpdate()
end

if AS:CheckAddOn("DPSMate") then
	function EMB:EmbedDPSMate()
		local parent = self.leftFrame
		if E.db.addOnSkins.embed.embedType == "DOUBLE" then
			parent = E.db.addOnSkins.embed.rightWindow == "DPSMate" and self.rightFrame or self.leftFrame
		end

		local frame, head
		for i, v in pairs(DPSMateSettings["windows"]) do
			if i == 1 then
				frame = _G["DPSMate_"..v["name"]]
				head = _G["DPSMate_"..v["name"].."_Head"]
				parent.frameName = "DPSMate_"..v.name
				if frame then
					frame:SetParent(parent)
					frame:ClearAllPoints()
					frame:SetAllPoints(parent)

					frame.fborder:Hide()

					head:SetFrameStrata("HIGH")
				end
			end
		end

		DPSMateSettings.lock = true
	end
end

if AS:CheckAddOn("KLHThreatMeter") then
	function EMB:EmbedKLHThreatMeter()
		local parent = self.leftFrame
		if E.db.addOnSkins.embed.embedType == "DOUBLE" then
			parent = E.db.addOnSkins.embed.rightWindow == "KLHThreatMeter" and self.rightFrame or self.leftFrame
		end
		parent.frameName = "KLHTM_Frame"

		KLHTM_Frame:SetParent(parent)
		KLHTM_Frame:ClearAllPoints()
		KLHTM_Frame:SetAllPoints(parent)
		KLHTM_Frame:SetFrameStrata("MEDIUM")

		E:Kill(KLHTM_TitleFramePin)
		E:Kill(KLHTM_TitleFrameUnpin)

		KLHTM_GuiState.pinned = true
	end
end

function EMB:Initialize()
	if E.db.addOnSkins.embed.embedType == "DISABLE" then return end

	self:EmbedCreate()
end

local function InitializeCallback()
	EMB:Initialize()
end

E:RegisterModule(EMB:GetName(), InitializeCallback)
