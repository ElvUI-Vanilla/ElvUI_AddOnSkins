local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- AtlasQuest v4.2 - https://github.com/Cabro/Atlas/

local function LoadSkin()
	if not E.private.addOnSkins.AtlasQuestCabro then return end

	local buttons = {
		STORYbutton,
		OPTIONbutton,
		CLOSEbutton3,
		AQOptionCloseButton,
	}

	local checkBoxes = {
		AQACB,
		AQHCB,
		AQFinishedQuest,
		AQAutoshowOption,
		AQLEFTOption,
		AQRIGHTOption,
		AQColourOption,
		AQCheckQuestlogButton,
		AQAutoQueryOption,
		AQNoQuerySpamOption,
		AQCompareTooltipOption,
	}

	local closeButtons = {
		CLOSEbutton,
		CLOSEbutton2,
	}

	for _, button in ipairs(buttons) do
		S:HandleButton(button)
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(checkBox)
	end
	for _, closeButton in ipairs(closeButtons) do
		S:HandleCloseButton(closeButton)
	end

	E:StripTextures(AtlasQuestFrame)
	E:SetTemplate(AtlasQuestFrame, "Transparent")
	AtlasQuestFrame:ClearAllPoints()
	E:Point(AtlasQuestFrame, "BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)

	AQ_HordeTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-HORDE")
	AQ_AllianceTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-ALLIANCE")

	if AtlasMap then
		E:Size(AtlasQuestInsideFrame, AtlasMap:GetWidth(), AtlasMap:GetHeight())
	end

	E:StripTextures(AtlasQuestOptionFrame)
	E:SetTemplate(AtlasQuestOptionFrame, "Transparent")

	CLOSEbutton:ClearAllPoints()
	E:Point(CLOSEbutton, "TOPLEFT", AtlasQuestFrame, "TOPLEFT", 4, -4)
	E:Size(CLOSEbutton, 32)

	E:Size(CLOSEbutton2, 32)

	E:SetTemplate(AtlasQuestTooltip, "Transparent")

	for i = 1, 6 do
		_G["AtlasQuestItemframe"..i.."_Icon"]:SetTexCoord(unpack(E.TexCoords));
	end

	AQ_AtlasOrAlphamap = function()
		if AtlasFrame and AtlasFrame:IsVisible() then
			AtlasORAlphaMap = "Atlas"
			AtlasQuestFrame:SetParent(AtlasFrame)

			if AQ_ShownSide == "Right" then
				AtlasQuestFrame:ClearAllPoints()
				E:Point(AtlasQuestFrame, "BOTTOMLEFT", AtlasFrame, "BOTTOMRIGHT", -1, 0)
			else
				AtlasQuestFrame:ClearAllPoints()
				E:Point(AtlasQuestFrame, "BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)
			end

			AtlasQuestInsideFrame:SetParent(AtlasFrame)
			AtlasQuestInsideFrame:ClearAllPoints()
			E:Point(AtlasQuestInsideFrame, "TOPLEFT", "AtlasFrame", 18, -84)
		elseif AlphaMapFrame and AlphaMapFrame:IsVisible() then
			AtlasORAlphaMap = "AlphaMap"
			AtlasQuestFrame:SetParent(AlphaMapFrame)

			if AQ_ShownSide == "Right" then
				AtlasQuestFrame:ClearAllPoints()
				E:Point(AtlasQuestFrame, "TOP", "AlphaMapFrame", 400, -107)
			else
				AtlasQuestFrame:ClearAllPoints()
				E:Point(AtlasQuestFrame, "TOPLEFT", "AlphaMapFrame", -195, -107)
			end

			AtlasQuestInsideFrame:SetParent(AlphaMapFrame)
			AtlasQuestInsideFrame:ClearAllPoints()
			E:Point(AtlasQuestInsideFrame, "TOPLEFT", "AlphaMapFrame", 1, -108)
		end
	end
end

S:AddCallbackForAddon("AtlasQuestCabro", "AtlasQuestCabro", LoadSkin)