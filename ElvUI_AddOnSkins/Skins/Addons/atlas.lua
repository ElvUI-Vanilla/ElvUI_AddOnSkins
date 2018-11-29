local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins");

-- Atlas 1.8.1 and Atlas 1.13.0 (TBC Backport)

local function LoadSkin()
	if not E.private.addOnSkins.Atlas then return end

	if ATLAS_VERSION == "1.8.1" then
		E:StripTextures(AtlasFrame)
		E:SetTemplate(AtlasFrame, "Transparent")

		E:StripTextures(AtlasOptionsFrame)
		E:SetTemplate(AtlasOptionsFrame, "Transparent")

		AtlasMap:SetDrawLayer("BORDER")

		E:Point(AtlasFrameCloseButton, "TOPRIGHT", AtlasFrame, "TOPRIGHT", -5, -7)
		E:Point(AtlasFrameLockButton, "RIGHT", AtlasFrameCloseButton, "LEFT", 12, 0)
		S:HandleCloseButton(AtlasFrameCloseButton)
		S:HandleCloseButton(AtlasFrameLockButton, nil, " ")

		AtlasLockNorm:SetTexCoord(.36, .65, .32, .73)
		E:SetInside(AtlasLockNorm, AtlasFrameLockButton, 10, 10)
		AtlasLockPush:SetTexCoord(.36, .60, .38, .76)
		E:SetInside(AtlasLockPush, AtlasFrameLockButton, 10, 10)

		S:SecureHook("Atlas_UpdateLock", function()
			AtlasLockNorm:SetDesaturated(true)
			AtlasLockPush:SetDesaturated(true)
		end)
		Atlas_UpdateLock()

		S:HandleDropDownBox(AtlasFrameDropDownType)
		S:HandleDropDownBox(AtlasFrameDropDown)

		S:HandleButton(AtlasFrameOptionsButton)

		S:HandleCheckBox(AtlasOptionsFrameToggleButton)
		S:HandleCheckBox(AtlasOptionsFrameAutoSelect)
		S:HandleCheckBox(AtlasOptionsFrameReplaceWorldMap)
		S:HandleCheckBox(AtlasOptionsFrameRightClick)
		S:HandleCheckBox(AtlasOptionsFrameAcronyms)

		S:HandleSliderFrame(SliderButtonPos)
		S:HandleSliderFrame(SliderAlpha)

		S:HandleButton(AtlasOptionsFrameResetPosition)
		S:HandleButton(AtlasOptionsFrameDone)
	elseif ATLAS_VERSION == "1.13.0" then

		for i, child in ipairs({AtlasFrame:GetRegions()}) do
			if i ~= 8 then
				E:Kill(child) -- E:StripTextures kills the dungeon map
			end
		end

		E:SetTemplate(AtlasFrame, "Transparent")

		E:StripTextures(AtlasOptionsFrame)
		E:SetTemplate(AtlasOptionsFrame, "Transparent")

		AtlasMap:SetDrawLayer("BORDER")

		E:Point(AtlasFrameCloseButton, "TOPRIGHT", AtlasFrame, "TOPRIGHT", -5, -7)
		E:Point(AtlasFrameLockButton, "RIGHT", AtlasFrameCloseButton, "LEFT", 12, 0)
		S:HandleCloseButton(AtlasFrameCloseButton)
		S:HandleCloseButton(AtlasFrameLockButton, nil, " ")

		AtlasLockNorm:SetTexCoord(.36, .65, .32, .73)
		E:SetInside(AtlasLockNorm, AtlasFrameLockButton, 10, 10)
		AtlasLockPush:SetTexCoord(.36, .60, .38, .76)
		E:SetInside(AtlasLockPush, AtlasFrameLockButton, 10, 10)

		S:SecureHook("Atlas_UpdateLock", function()
			AtlasLockNorm:SetDesaturated(true)
			AtlasLockPush:SetDesaturated(true)
		end)

		Atlas_UpdateLock()

		S:HandleDropDownBox(AtlasFrameDropDownType)
		S:HandleDropDownBox(AtlasFrameDropDown)

		S:HandleEditBox(AtlasSearchEditBox)
		E:Height(AtlasSearchEditBox, 22)

		S:HandleButton(AtlasSwitchButton)
		E:Height(AtlasSwitchButton, 24)
		S:HandleButton(AtlasSearchButton)
		E:Height(AtlasSearchButton, 24)
		E:Point(AtlasSearchButton, "LEFT", AtlasSearchEditBox, "RIGHT", 3, 0)
		S:HandleButton(AtlasSearchClearButton)
		E:Height(AtlasSearchClearButton, 24)
		E:Point(AtlasSearchClearButton, "LEFT", AtlasSearchButton, "RIGHT", 2, 0)
		S:HandleButton(AtlasFrameOptionsButton)

		S:HandleScrollBar(AtlasScrollBarScrollBar)

		S:HandleCheckBox(AtlasOptionsFrameToggleButton)
		S:HandleCheckBox(AtlasOptionsFrameAutoSelect)
		S:HandleCheckBox(AtlasOptionsFrameRightClick)
		S:HandleCheckBox(AtlasOptionsFrameAcronyms)
		S:HandleCheckBox(AtlasOptionsFrameClamped)

		S:HandleSliderFrame(AtlasOptionsFrameSliderButtonPos)
		S:HandleSliderFrame(AtlasOptionsFrameSliderButtonRad)
		S:HandleSliderFrame(AtlasOptionsFrameSliderAlpha)
		S:HandleSliderFrame(AtlasOptionsFrameSliderScale)

		S:HandleDropDownBox(AtlasOptionsFrameDropDownCats)

		S:HandleButton(AtlasOptionsFrameResetPosition)
		S:HandleButton(AtlasOptionsFrameDone)
	end
end

S:AddCallbackForAddon("Atlas", "Atlas", LoadSkin)