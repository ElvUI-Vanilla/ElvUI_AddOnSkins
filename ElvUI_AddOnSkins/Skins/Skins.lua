local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local AS = E:GetModule("AddOnSkins");
local S = E:GetModule("Skins");

--Cache global variables
--Lua functions
local select = select

function AS:Desaturate(frame, point)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") then
			local Texture = region:GetTexture()
			if type(Texture) == "string" and strlower(Texture) == "interface\\dialogframe\\ui-dialogbox-corner" then
				region:SetTexture(nil)
				E:Kill(region)
			else
				region:SetDesaturated(true)
			end
		end
	end

	HookScript(frame, "OnUpdate", function()
		if this:GetNormalTexture() then
			this:GetNormalTexture():SetDesaturated(true)
		end
		if this:GetPushedTexture() then
			this:GetPushedTexture():SetDesaturated(true)
		end
		if this:GetHighlightTexture() then
			this:GetHighlightTexture():SetDesaturated(true)
		end
	end)
end

function AS:AcceptFrame(MainText, Function)
	if not AcceptFrame then
		AcceptFrame = CreateFrame("Frame", "AcceptFrame", UIParent)
		E:SetTemplate(AcceptFrame, "Transparent")
		E:Point(AcceptFrame, "CENTER", UIParent, "CENTER")
		AcceptFrame:SetFrameStrata("DIALOG")

		AcceptFrame.Text = AcceptFrame:CreateFontString(nil, "OVERLAY")
		E:FontTemplate(AcceptFrame.Text)
		E:Point(AcceptFrame.Text, "TOP", AcceptFrame, "TOP", 0, -10)

		AcceptFrame.Accept = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Accept)
		E:Size(AcceptFrame.Accept, 70, 25)
		E:Point(AcceptFrame.Accept, "RIGHT", AcceptFrame, "BOTTOM", -10, 20)
		AcceptFrame.Accept:SetFormattedText("|cFFFFFFFF%s|r", YES)

		AcceptFrame.Close = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Close)
		E:Size(AcceptFrame.Close, 70, 25)
		E:Point(AcceptFrame.Close, "LEFT", AcceptFrame, "BOTTOM", 10, 20)
		AcceptFrame.Close:SetScript("OnClick", function() this:GetParent():Hide() end)
		AcceptFrame.Close:SetText(format("|cFFFFFFFF%s|r", NO))
	end
	AcceptFrame.Text:SetText(MainText)
	E:Size(AcceptFrame, AcceptFrame.Text:GetStringWidth() + 100, AcceptFrame.Text:GetStringHeight() + 60)
	AcceptFrame.Accept:SetScript("OnClick", Function)
	AcceptFrame:Show()
end