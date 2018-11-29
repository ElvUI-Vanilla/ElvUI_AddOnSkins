local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins");

-- DPSMate v130

local function LoadSkin()
	if not E.private.addOnSkins.DPSMate then return end

	-- GUI Window
	local frame, head, enable
	for i, v in pairs(DPSMateSettings["windows"]) do
		if i == 1 then
			frame = _G["DPSMate_"..v["name"]]
			head = _G["DPSMate_"..v["name"].."_Head"]
			enable = _G["DPSMate_"..v["name"].."_Head_Enable"]
			if frame then
				E:StripTextures(frame)
				E:SetTemplate(frame, "Transparent")

				E:StripTextures(head)
				E:SetTemplate(head, "Transparent")

				S:HandleCheckBox(enable)
			end
		end
	end

	-- Config
	DPSMate_ConfigMenu:SetScale(UIParent:GetScale())
	E:StripTextures(DPSMate_ConfigMenu)
	E:SetTemplate(DPSMate_ConfigMenu, "Transparent")

	-- Frames
	local DPSMateFrames = {
		"ConfigMenu_Menu",
		"ConfigMenu_Tab_Bars",
		"ConfigMenu_Tab_TitleBar",
		"ConfigMenu_Tab_TitleBar_Box1",
		"ConfigMenu_Tab_Content",
		"ConfigMenu_Tab_Window",
		"ConfigMenu_Tab_DataResets",
		"ConfigMenu_Tab_GeneralOptions",
		"ConfigMenu_Tab_Columns",
		"ConfigMenu_Tab_Columns_Child",
		"ConfigMenu_Tab_Columns_Child_DPS",
		"ConfigMenu_Tab_Columns_Child_Damage",
		"ConfigMenu_Tab_Columns_Child_DamageTaken",
		"ConfigMenu_Tab_Columns_Child_DTPS",
		"ConfigMenu_Tab_Columns_Child_EDD",
		"ConfigMenu_Tab_Columns_Child_EDT",
		"ConfigMenu_Tab_Columns_Child_Healing",
		"ConfigMenu_Tab_Columns_Child_HealingTaken",
		"ConfigMenu_Tab_Columns_Child_HPS",
		"ConfigMenu_Tab_Columns_Child_Overhealing",
		"ConfigMenu_Tab_Columns_Child_EffectiveHealing",
		"ConfigMenu_Tab_Columns_Child_EffectiveHealingTaken",
		"ConfigMenu_Tab_Columns_Child_EffectiveHPS",
		"ConfigMenu_Tab_Columns_Child_EffectiveHPS",
		"ConfigMenu_Tab_Columns_Child_HAB",
		"ConfigMenu_Tab_Columns_Child_FriendlyFire",
		"ConfigMenu_Tab_Columns_Child_Threat",
		"ConfigMenu_Tab_Columns_Child_TPS",
		"ConfigMenu_Tab_Columns_Child_Absorbs",
		"ConfigMenu_Tab_Columns_Child_AbsorbsTaken",
		"ConfigMenu_Tab_Columns_Child_OHealingTaken",
		"ConfigMenu_Tab_Columns_Child_OHPS",
		"ConfigMenu_Tab_Columns_Child_FriendlyFireTaken",
		"ConfigMenu_Tab_Columns_Child_Deaths",
		"ConfigMenu_Tab_Columns_Child_Interrupts",
		"ConfigMenu_Tab_Columns_Child_Dispels",
		"ConfigMenu_Tab_Columns_Child_DispelsReceived",
		"ConfigMenu_Tab_Columns_Child_Decurses",
		"ConfigMenu_Tab_Columns_Child_DecursesReceived",
		"ConfigMenu_Tab_Columns_Child_Disease",
		"ConfigMenu_Tab_Columns_Child_DiseaseReceived",
		"ConfigMenu_Tab_Columns_Child_Poison",
		"ConfigMenu_Tab_Columns_Child_PoisonReceived",
		"ConfigMenu_Tab_Columns_Child_Magic",
		"ConfigMenu_Tab_Columns_Child_MagicReceived",
		"ConfigMenu_Tab_Columns_Child_AurasGained",
		"ConfigMenu_Tab_Columns_Child_AurasLost",
		"ConfigMenu_Tab_Columns_Child_AuraUptime",
		"ConfigMenu_Tab_Columns_Child_Procs",
		"ConfigMenu_Tab_Columns_Child_Casts",
		"ConfigMenu_Tab_Columns_Child_Fails",
		"ConfigMenu_Tab_Columns_Child_CCBreaker",
		"ConfigMenu_Tab_Tooltips",
		"ConfigMenu_Tab_Modes",
		"ConfigMenu_Tab_Modes_left",
		"ConfigMenu_Tab_Modes_right",
		"ConfigMenu_Tab_RaidLeader",
		"ConfigMenu_Tab_Broadcasting",
		"ConfigMenu_Tab_About",
		"ConfigMenu_Tab_About_Who",
		"ConfigMenu_Tab_About_What",
		"ConfigMenu_Tab_About_Thanks"
	}
	for i = 1, getn(DPSMateFrames) do
		local DPSMateFrame = _G["DPSMate_"..DPSMateFrames[i]]
		if DPSMateFrame then
			E:StripTextures(DPSMateFrame)
			E:SetTemplate(DPSMateFrame, "Transparent")
		end
	end

	-- Buttons
	local DPSMateButtons = {
		"GeneralMinimisedClearThreat",
		"OptionsFrameControlsClose",
		"SelfFrameBottomReset",
		"Tab_Modes_moveLeft",
		"Tab_Modes_moveRight",
		"Tab_RaidLeader_HelloWorld",
		"Tab_Window_Submit",
		"Tab_Window_ButtonRemove",
		"Tab_Window_ButtonCopy"
	}
	for i = 1, getn(DPSMateButtons) do
		local DPSMateButton = _G["DPSMate_ConfigMenu_"..DPSMateButtons[i]]
		if DPSMateButton then
			S:HandleButton(DPSMateButton)
			E:Height(DPSMateButton, 18)
		end
	end

	-- DropDown
	local DPSMateDropDowns = {
		"Bars_BarFont",
		"Bars_BarFontFlag",
		"Bars_BarTexture",
		"Content_BGDropDown",
		"Content_NumberFormat",
		"Content_BorderTexture",
		"Content_BorderStrata",
		"DataResets_EnteringWorld",
		"DataResets_PartyMemberChanged",
		"DataResets_Sync",
		"DataResets_JoinParty",
		"DataResets_LeaveParty",
		"DataResets_Logout",
		"TitleBar_BarFont",
		"TitleBar_BarFontFlag",
		"TitleBar_BarTexture",
		"Tooltips_Position",
		"Window_Remove",
		"Window_ConfigFrom",
		"Window_ConfigTo"
	}
	for i = 1, getn(DPSMateDropDowns) do
		local DPSMateDropDown = _G["DPSMate_ConfigMenu_Tab_"..DPSMateDropDowns[i]]
		if DPSMateDropDown then
			S:HandleDropDownBox(DPSMateDropDown)
		end
	end

	-- CheckBox
	local DPSMateCheckBoxes = {
		"Bars_ClassIcons",
		"Bars_Ranks",
		"Bars_DisableBG",
		"Broadcasting_Enable",
		"Broadcasting_Cooldowns",
		"Broadcasting_Ress",
		"Broadcasting_KillingBlows",
		"Broadcasting_Fails",
		"Broadcasting_RaidWarning",
		"GeneralOptions_Minimap",
		"GeneralOptions_Total",
		"GeneralOptions_Solo",
		"GeneralOptions_Combat",
		"GeneralOptions_Login",
		"GeneralOptions_BossFights",
		"GeneralOptions_PVP",
		"GeneralOptions_Disable",
		"GeneralOptions_MergePets",
		"TitleBar_Enable",
		"TitleBar_Box1_Report",
		"TitleBar_Box1_Mode",
		"TitleBar_Box1_Filter",
		"TitleBar_Box1_Reset",
		"TitleBar_Box1_Config",
		"TitleBar_Box1_CBTDisplay",
		"TitleBar_Box1_Sync",
		"TitleBar_Box1_Enable",
		"Tooltips_Tooltips",
		"Tooltips_InformativeTooltips",
		"Window_Lock",
		"Window_Testmode"
	}
	for i = 1, getn(DPSMateCheckBoxes) do
		local DPSMateCheckBox = _G["DPSMate_ConfigMenu_Tab_"..DPSMateCheckBoxes[i]]
		if DPSMateCheckBox then
			S:HandleCheckBox(DPSMateCheckBox)
		end
	end

	local DPSMateCheckBoxes1 = {
		"DPS",
		"Damage",
		"DamageTaken",
		"DTPS",
		"EDD",
		"EDT",
		"Healing",
		"HealingTaken",
		"HPS",
		"Overhealing",
		"EffectiveHealing",
		"EffectiveHealingTaken",
		"EffectiveHPS",
		"EffectiveHPS",
		"HAB",
		"FriendlyFire",
		"Threat",
		"TPS",
		"Absorbs",
		"AbsorbsTaken",
		"OHealingTaken",
		"OHPS",
		"FriendlyFireTaken",
	}
	local DPSMateCheckBoxes2 = {
		"Deaths",
		"Interrupts",
		"Dispels",
		"DispelsReceived",
		"Decurses",
		"DecursesReceived",
		"Disease",
		"DiseaseReceived",
		"Poison",
		"PoisonReceived",
		"Magic",
		"MagicReceived",
		"AurasGained",
		"AurasLost",
		"AuraUptime",
		"Procs",
		"Casts",
		"Fails",
		"CCBreaker",
	}
	for i = 1, 4 do
		for _, v in ipairs(DPSMateCheckBoxes1) do
			local DPSMateCheckBox = _G["DPSMate_ConfigMenu_Tab_Columns_Child_"..v.."_Check"..i]
			if DPSMateCheckBox then
				S:HandleCheckBox(DPSMateCheckBox, true)
			end
		end
	end
	for i = 1, 2 do
		for _, v in ipairs(DPSMateCheckBoxes2) do
			local DPSMateCheckBox = _G["DPSMate_ConfigMenu_Tab_Columns_Child_"..v.."_Check"..i]
			if DPSMateCheckBox then
				S:HandleCheckBox(DPSMateCheckBox, true)
			end
		end
	end

	-- Slider
	local DPSMateSliders = {
		"Bars_BarFontSize",
		"Bars_BarSpacing",
		"Bars_BarHeight",
		"Bars_TotalAlpha",
		"Content_Scale",
		"Content_Opacity",
		"Content_BGOpacity",
		"Content_BorderOpacity",
		"GeneralOptions_Segments",
		"GeneralOptions_TargetScale",
		"TitleBar_BarFontSize",
		"TitleBar_BarHeight",
		"TitleBar_BGOpacity",
		"Tooltips_Rows",
	}
	for i = 1, getn(DPSMateSliders) do
		local DPSMateSlider = _G["DPSMate_ConfigMenu_Tab_"..DPSMateSliders[i]]
		if DPSMateSlider then
			S:HandleSliderFrame(DPSMateSlider)
		end
	end

	-- EditBox
	local DPSMateEditBoxes = {
		"Bars_BarFontSize_Editbox",
		"Bars_BarSpacing_Editbox",
		"Bars_BarHeight_Editbox",
		"Bars_TotalAlpha_Editbox",
		"Content_Scale_Editbox",
		"Content_Opacity_Editbox",
		"Content_BGOpacity_Editbox",
		"Content_BorderOpacity_Editbox",
		"GeneralOptions_Segments_Editbox",
		"GeneralOptions_TargetScale_Editbox",
		"TitleBar_BarFontSize_Editbox",
		"TitleBar_BarHeight_Editbox",
		"TitleBar_BGOpacity_Editbox",
		"Tooltips_Rows_Editbox",
		"Window_Editbox",
	}
	for i = 1, getn(DPSMateEditBoxes) do
		local DPSMateEditBox = _G["DPSMate_ConfigMenu_Tab_"..DPSMateEditBoxes[i]]
		if DPSMateEditBox then
			S:HandleEditBox(DPSMateEditBox)
		end
	end

	-- CloseButton
	S:HandleCloseButton(DPSMate_ConfigMenu_Close)
	E:Size(DPSMate_ConfigMenu_Close, 32)
end

S:AddCallbackForAddon("DPSMate", "DPSMate", LoadSkin)