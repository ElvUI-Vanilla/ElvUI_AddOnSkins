local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins");

-- AtlasLoot 1.18.02 and AtlasLoot 4.07.01 (TBC Backport)

local function LoadSkin()
	if not E.private.addOnSkins.AtlasLoot then return end
	local version = GetAddOnMetadata("AtlasLoot", "Version")

	if version == "1.18.02" then
		HookScript(AtlasLootTooltip, "OnShow", function()
			E:SetTemplate(this, "Transparent")
		end)

		for i = 1, 30 do
			_G["AtlasLootItem_" .. i .. "_Icon"]:SetTexCoord(unpack(E.TexCoords))
			E:CreateBackdrop(_G["AtlasLootItem_" .. i], "Default")
			E:SetOutside(_G["AtlasLootItem_" .. i].backdrop, _G["AtlasLootItem_" .. i .. "_Icon"])
		end

		local classButton = {
			"Druid",
			"Hunter",
			"Mage",
			"Paladin",
			"Priest",
			"Rogue",
			"Shaman",
			"Warlock",
			"Warrior"
		}
		for i = 1, getn(classButton) do
			S:HandleButton(_G["AtlasLootItemsFrame_" .. classButton[i]])
		end

		S:HandleButton(AtlasLootItemsFrame_BACK)
		S:HandleNextPrevButton(AtlasLootItemsFrame_NEXT)
		S:HandleNextPrevButton(AtlasLootItemsFrame_PREV)

		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0)

		E:StripTextures(AtlasLootOptionsFrame)
		E:SetTemplate(AtlasLootOptionsFrame, "Transparent")

		S:HandleCheckBox(AtlasLootOptionsFrameSafeLinks)
		S:HandleCheckBox(AtlasLootOptionsFrameAllLinks)
		S:HandleCheckBox(AtlasLootOptionsFrameDefaultTT)
		S:HandleCheckBox(AtlasLootOptionsFrameLootlinkTT)
		S:HandleCheckBox(AtlasLootOptionsFrameItemSyncTT)
		S:HandleCheckBox(AtlasLootOptionsFrameEquipCompare)

		S:HandleButton(AtlasLootOptionsFrameDone)

		E:StripTextures(AtlasLootPanel)
		E:SetTemplate(AtlasLootPanel, "Transparent")

		S:HandleButton(AtlasLootPanel_Sets)
		S:HandleButton(AtlasLootPanel_Options)
	elseif version == "4.07.01" then
		--[[
		HookScript(AtlasLootTooltip, "OnShow", function()
			E:SetTemplate(this, "Transparent")

			local iLink = select(2, this:GetItem())
			local quality = iLink and select(3, GetItemInfo(iLink))
			if quality and quality >= 2 then
				this:SetBackdropBorderColor(GetItemQualityColor(quality))
			else
				this:SetBackdropBorderColor(unpack(E["media"].bordercolor))
			end
		end)
		--]]

		E:StripTextures(AtlasLootDefaultFrame)
		E:SetTemplate(AtlasLootDefaultFrame, "Transparent")

		S:HandleCloseButton(AtlasLootDefaultFrame_CloseButton)
		S:HandleButton(AtlasLootDefaultFrame_Atlas)
		S:HandleButton(AtlasLootDefaultFrame_Options)
		S:HandleButton(AtlasLootDefaultFrame_Menu)
		S:HandleButton(AtlasLootDefaultFrame_SubMenu)
		E:SetTemplate(AtlasLootDefaultFrame_LootBackground, "Default", nil, true)
		AtlasLootDefaultFrame_LootBackground_Back:SetTexture(0, 0, 0, 0)
		S:HandleButton(AtlasLootDefaultFrame_Preset1)
		S:HandleButton(AtlasLootDefaultFrame_Preset2)
		S:HandleButton(AtlasLootDefaultFrame_Preset3)
		S:HandleButton(AtlasLootDefaultFrame_Preset4)
		S:HandleEditBox(AtlasLootDefaultFrameSearchBox)
		AtlasLootDefaultFrameSearchBox:SetPoint("BOTTOM", AtlasLootDefaultFrame, "BOTTOM", -78, 30)
		AtlasLootDefaultFrameSearchBox:SetHeight(22)
		S:HandleButton(AtlasLootDefaultFrameSearchButton)
		AtlasLootDefaultFrameSearchButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchBox, "RIGHT", 3, 0)
		S:HandleNextPrevButton(AtlasLootDefaultFrameSearchOptionsButton)
		AtlasLootDefaultFrameSearchOptionsButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchButton, "RIGHT", 2, 0)
		AtlasLootDefaultFrameSearchOptionsButton:SetWidth(24)
		AtlasLootDefaultFrameSearchOptionsButton:SetHeight(24)
		S:HandleButton(AtlasLootDefaultFrameSearchClearButton)
		AtlasLootDefaultFrameSearchClearButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchOptionsButton, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootDefaultFrameLastResultButton)
		AtlasLootDefaultFrameLastResultButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchClearButton, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootDefaultFrameWishListButton)
		AtlasLootDefaultFrameWishListButton:SetPoint("RIGHT", AtlasLootDefaultFrameSearchBox, "LEFT", -2, 0)

		S:HandleCloseButton(AtlasLootItemsFrame_CloseButton)

		S:HandleButton(AtlasLootInfoHidePanel)

		for i = 1, 30 do
			_G["AtlasLootItem_" .. i .. "_Icon"]:SetTexCoord(unpack(E.TexCoords))
			E:CreateBackdrop(_G["AtlasLootItem_" .. i], "Default")
			E:SetOutside(_G["AtlasLootItem_" .. i].backdrop, _G["AtlasLootItem_" .. i .. "_Icon"])

			_G["AtlasLootMenuItem_" .. i .. "_Icon"]:SetTexCoord(unpack(E.TexCoords))
			E:CreateBackdrop(_G["AtlasLootMenuItem_" .. i], "Default")
			E:SetOutside(_G["AtlasLootMenuItem_" .. i].backdrop, _G["AtlasLootMenuItem_" .. i .. "_Icon"])
		end

		S:HandleButton(AtlasLootItemsFrame_BACK)
		S:HandleNextPrevButton(AtlasLootItemsFrame_NEXT)
		S:HandleButton(AtlasLootServerQueryButton)
		S:HandleNextPrevButton(AtlasLootQuickLooksButton)
		S:HandleNextPrevButton(AtlasLootItemsFrame_PREV)

		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0)

		E:StripTextures(AtlasLootOptionsFrame)
		E:SetTemplate(AtlasLootOptionsFrame, "Transparent")

		S:HandleCheckBox(AtlasLootOptionsFrameDefaultTT)
		S:HandleCheckBox(AtlasLootOptionsFrameLootlinkTT)
		S:HandleCheckBox(AtlasLootOptionsFrameItemSyncTT)
		S:HandleCheckBox(AtlasLootOptionsFrameOpaque)
		S:HandleCheckBox(AtlasLootOptionsFrameItemID)
		S:HandleCheckBox(AtlasLootOptionsFrameSafeLinks)
		S:HandleCheckBox(AtlasLootOptionsFrameAllLinks)
		S:HandleCheckBox(AtlasLootOptionsFrameEquipCompare)
		S:HandleCheckBox(AtlasLootOptionsFrameItemSpam)
		S:HandleCheckBox(AtlasLootOptionsFrameMinimap)
		S:HandleCheckBox(AtlasLootOptionsFrameHidePanel)

		S:HandleSliderFrame(AtlasLootOptionsFrameSliderButtonPos)
		S:HandleSliderFrame(AtlasLootOptionsFrameSliderButtonRad)

		S:HandleButton(AtlasLootOptionsFrameDefaultSettings)
		S:HandleButton(AtlasLootOptionsFrameDone)
		S:HandleButton(AtlasLootOptionsFrameResetPosition)

		E:StripTextures(AtlasLootPanel)
		E:SetTemplate(AtlasLootPanel, "Transparent")

		S:HandleButton(AtlasLootPanel_WorldEvents)
		AtlasLootPanel_WorldEvents:SetPoint("LEFT", AtlasLootPanel, "LEFT", 7, 29)
		S:HandleButton(AtlasLootPanel_Sets)
		AtlasLootPanel_Sets:SetPoint("LEFT", AtlasLootPanel_WorldEvents, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootPanel_Reputation)
		AtlasLootPanel_Reputation:SetPoint("LEFT", AtlasLootPanel_Sets, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootPanel_PvP)
		AtlasLootPanel_PvP:SetPoint("LEFT", AtlasLootPanel_Reputation, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootPanel_Crafting)
		AtlasLootPanel_Crafting:SetPoint("LEFT", AtlasLootPanel_PvP, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootPanel_WishList)
		AtlasLootPanel_WishList:SetPoint("LEFT", AtlasLootPanel_Crafting, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootPanel_Options)
		S:HandleButton(AtlasLootPanel_AtlasLoot)
		S:HandleButton(AtlasLootPanel_Preset1)
		S:HandleButton(AtlasLootPanel_Preset2)
		S:HandleButton(AtlasLootPanel_Preset3)
		S:HandleButton(AtlasLootPanel_Preset4)

		S:HandleEditBox(AtlasLootSearchBox)
		AtlasLootSearchBox:SetHeight(20)
		S:HandleButton(AtlasLootSearchButton)
		AtlasLootSearchButton:SetHeight(22)
		AtlasLootSearchButton:SetPoint("LEFT", AtlasLootSearchBox, "RIGHT", 3, 0)
		S:HandleNextPrevButton(AtlasLootSearchOptionsButton)
		AtlasLootSearchOptionsButton:SetPoint("LEFT", AtlasLootSearchButton, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootSearchClearButton)
		AtlasLootSearchClearButton:SetHeight(22)
		AtlasLootSearchClearButton:SetPoint("LEFT", AtlasLootSearchOptionsButton, "RIGHT", 2, 0)
		S:HandleButton(AtlasLootLastResultButton)
		AtlasLootLastResultButton:SetHeight(22)
		AtlasLootLastResultButton:SetPoint("LEFT", AtlasLootSearchClearButton, "RIGHT", 2, 0)

		hooksecurefunc("AtlasLoot_SetupForAtlas", function()
			AtlasLootPanel:ClearAllPoints()
			AtlasLootPanel:SetParent(AtlasFrame)
			AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, -2)
		end)

		E:GetModule("AddOnSkins"):SkinLibrary("AceAddon-2.0")
		E:GetModule("AddOnSkins"):SkinLibrary("Dewdrop-2.0")
		E:GetModule("AddOnSkins"):SkinLibrary("Tablet-2.0")
	end
end

S:AddCallbackForAddon("AtlasLoot", "AtlasLoot", LoadSkin)