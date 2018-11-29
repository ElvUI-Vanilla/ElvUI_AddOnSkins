local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins");

-- KLHThreatMeter v17.35

local function LoadSkin()
	if not E.private.addOnSkins.KLHThreatMeter then return end

	-- Frames
	local KLHTMFrames = {
		"Frame",
		"OptionsFrame",
		"OptionsFrameControls",
		"OptionsFrameTitle",
		"RaidFrameBottom",
		"SelfFrame",
		"SelfFrameBottom",
		"TitleFrameLongTitle"
	}
	for i = 1, getn(KLHTMFrames) do
		local KLHTMFrame = _G["KLHTM_"..KLHTMFrames[i]]
		if KLHTMFrame then
			E:StripTextures(KLHTMFrame)
		end
	end

	E:SetTemplate(KLHTM_Frame, "Transparent")
	E:SetTemplate(KLHTM_OptionsFrame, "Transparent")
	E:SetTemplate(KLHTM_OptionsFrameTitle, "Transparent")

	-- CheckBoxes
	local KLHTMCheckBoxs = {
		"GeneralMinimisedPin",
		"GeneralMinimisedOptions",
		"GeneralMinimisedView",
		"GeneralMinimisedMasterTarget",
		"GeneralMinimisedClearThreat",
		"GeneralMaximisedPin",
		"GeneralMaximisedView",
		"GeneralMaximisedMasterTarget",
		"GeneralMaximisedClearThreat",
		"SelfColumnThreatPercent",
		"SelfColumnThreat",
		"SelfColumnRage",
		"SelfColumnDamage",
		"SelfMinimisedThreat",
		"SelfHideZero",
		"SelfAbbreviate",
		"RaidColumnThreatPercent",
		"RaidColumnThreat",
		"RaidMinimisedRank",
		"RaidMinimisedThreatPercent",
		"RaidMinimisedDeficit",
		"RaidHideZero",
		"RaidResize",
		"RaidAbbreviate",
		"RaidAggroGain",
		"RaidHideBottom"
	}
	for i = 1, getn(KLHTMCheckBoxs) do
		local KLHTMCheckBox = _G["KLHTM_OptionsFrame"..KLHTMCheckBoxs[i]]
		if KLHTMCheckBox then
			S:HandleCheckBox(KLHTMCheckBox)
		end
	end

	-- Buttons
	local KLHTMButtons = {
		"OptionsFrameControlsGeneral",
		"OptionsFrameControlsSelf",
		"OptionsFrameControlsRaid",
		"OptionsFrameControlsClose",
		"GeneralMinimisedClearThreat",
		"SelfFrameBottomReset"
	}
	for i = 1, getn(KLHTMButtons) do
		local KLHTMButton = _G["KLHTM_"..KLHTMButtons[i]]
		if KLHTMButton then
			S:HandleButton(KLHTMButton)
		end
	end

	-- Slider
	S:HandleSliderFrame(KLHTM_OptionsFrameRaidRows)

	-- Misc
	KLHTM_GuiState.pinned = true

	E:Kill(KLHTM_TitleFramePin)
	E:Kill(KLHTM_TitleFrameUnpin)
	E:Kill(KLHTM_OptionsFrameGeneralScale)
	E:Kill(KLHTM_OptionsFrameGeneralHeaderOther)
end

S:AddCallbackForAddon("KLHThreatMeter", "KLHThreatMeter", LoadSkin)