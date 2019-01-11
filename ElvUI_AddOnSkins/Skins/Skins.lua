local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local AS = E:GetModule("AddOnSkins");
local S = E:GetModule("Skins");

--Cache global variables
--Lua functions
local select, type = select, type
local format, lower = string.format, string.lower
--WoW API / Variables
local CreateFrame = CreateFrame

AS.SQUARE_BUTTON_TEXCOORDS = {
	["HELP"]	= {0, 0.125, 0, 0.125};
	["TOP"]		= {0, 0.125, 0.125, 0.25};
	["BOTTOM"]	= {0, 0.125, 0.25, 0.375};
	["FILE"]	= {0, 0.125, 0.375, 0.5};
	["LOCK"]	= {0, 0.125, 0.5, 0.625};
	["CLOSE"]	= {0.125, 0.25, 0, 0.125};
	["UP"]		= {0.125, 0.25, 0.125, 0.25};
	["DOWN"]	= {0.125, 0.25, 0.25, 0.375};
	["PLUS"]	= {0.125, 0.25, 0.375, 0.5};
	["MINUS"]	= {0.125, 0.25, 0.5, 0.625};
	["GEAR"]	= {0.25, 0.375, 0, 0.125};
	["MARK"]	= {0.25, 0.375, 0.125, 0.25};
	["STOP"]	= {0.25, 0.375, 0.25, 0.375};
	["PAUSE"]	= {0.25, 0.375, 0.375, 0.5};
}

function AS:HandleSquareButton(button, name, iconSize, noTemplate)
	E:StripTextures(button)
	button:SetNormalTexture("")
	button:SetPushedTexture("")
	button:SetHighlightTexture("")
	button:SetDisabledTexture("")

	if not button.icon then
		button.icon = button:CreateTexture(nil, "ARTWORK")
		E:Size(button.icon, iconSize or 18)
		E:Point(button.icon, "CENTER")
		button.icon:SetTexture([[Interface\AddOns\ElvUI_AddOnSkins\media\SquareButtons]])

		button:SetScript("OnMouseDown", function()
			if button:IsEnabled() == 1 then
				E:Point(this.icon, "CENTER", -1, -1)
			end
		end)

		button:SetScript("OnMouseUp", function()
			E:Point(this.icon, "CENTER", 0, 0)
		end)

		hooksecurefunc(button, "Disable", function(self)
			SetDesaturation(self.icon, true)
			self.icon:SetAlpha(0.5)
		end)

		hooksecurefunc(button, "Enable", function(self)
			SetDesaturation(self.icon, false)
			self.icon:SetAlpha(1.0)
		end)

		if button:IsEnabled() == 0 then
			SetDesaturation(button.icon, true)
			button.icon:SetAlpha(0.5)
		end

		local coords = AS.SQUARE_BUTTON_TEXCOORDS[strupper(name)]
		if coords then
			button.icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
		end
	end

	if not noTemplate then
		E:SetTemplate(button, "Default", true)
		HookScript(button"OnEnter", S.SetModifiedBackdrop)
		HookScript(button"OnLeave", S.SetOriginalBackdrop)
	end
end

function AS:Desaturate(frame, point)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") then
			local Texture = region:GetTexture()
			if type(Texture) == "string" and lower(Texture) == "interface\\dialogframe\\ui-dialogbox-corner" then
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
		E:Point(E, AcceptFrame, "CENTER", UIParent, "CENTER")
		AcceptFrame:SetFrameStrata("DIALOG")

		AcceptFrame.Text = AcceptFrame:CreateFontString(nil, "OVERLAY")
		E:FontTemplate(AcceptFrame.Text)
		E:Point(E, AcceptFrame.Text, "TOP", AcceptFrame, "TOP", 0, -10)

		AcceptFrame.Accept = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Accept)
		E:Size(AcceptFrame.Accept, 70, 25)
		E:Point(E, AcceptFrame.Accept, "RIGHT", AcceptFrame, "BOTTOM", -10, 20)
		AcceptFrame.Accept:SetFormattedText("|cFFFFFFFF%s|r", YES)

		AcceptFrame.Close = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Close)
		E:Size(AcceptFrame.Close, 70, 25)
		E:Point(E, AcceptFrame.Close, "LEFT", AcceptFrame, "BOTTOM", 10, 20)
		AcceptFrame.Close:SetScript("OnClick", function() this:GetParent():Hide() end)
		AcceptFrame.Close:SetText(format("|cFFFFFFFF%s|r", NO))
	end
	AcceptFrame.Text:SetText(MainText)
	E:Size(AcceptFrame, AcceptFrame.Text:GetStringWidth() + 100, AcceptFrame.Text:GetStringHeight() + 60)
	AcceptFrame.Accept:SetScript("OnClick", Function)
	AcceptFrame:Show()
end
