local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.AtlasLoot then return end

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
end

S:AddCallbackForAddon("AtlasLoot", "AtlasLoot", LoadSkin)