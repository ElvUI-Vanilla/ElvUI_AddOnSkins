local E, L, V, P, G, _ = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.WowLuaVanilla then return end

	E:StripTextures(WowLuaFrame)
	E:SetTemplate(WowLuaFrame, "Transparent")
	E:StripTextures(WowLuaFrameLineNumScrollFrame)
	E:StripTextures(WowLuaFrameResizeBar)
	WowLuaFrameResizeBar:SetHeight(10)
	S:HandleCloseButton(WowLuaButton_Close)
	WowLuaButton_Close:SetPoint("TOPRIGHT", WowLuaFrame, "TOPRIGHT", 0 , 0)
	S:HandleScrollBar(WowLuaFrameEditScrollFrameScrollBar)
	WowLuaButton_New:SetPoint("LEFT", WowLuaFrameToolbar, "LEFT", 0, 0)

	WowLuaFrameEditFocusGrabber.bg1 = CreateFrame("Frame", nil, WowLuaFrameEditFocusGrabber)
	E:CreateBackdrop(WowLuaFrameEditFocusGrabber.bg1)
	WowLuaFrameEditFocusGrabber.bg1:SetPoint("TOPLEFT", 0, 0)
	WowLuaFrameEditFocusGrabber.bg1:SetPoint("BOTTOMRIGHT", 5, -5)

	E:StripTextures(WowLuaFrameCommand)
	WowLuaFrameCommand.bg1 = CreateFrame("Frame", nil, WowLuaFrameCommand)
	E:CreateBackdrop(WowLuaFrameCommand.bg1)
	WowLuaFrameCommand.bg1:SetPoint("TOPLEFT", -2, 0)
	WowLuaFrameCommand.bg1:SetPoint("BOTTOMRIGHT", -10, 0)

	local Buttons = {
		WowLuaButton_New,
		WowLuaButton_Open,
		WowLuaButton_Save,
		WowLuaButton_Undo,
		WowLuaButton_Redo,
		WowLuaButton_Delete,
		WowLuaButton_Lock,
		WowLuaButton_Unlock,
		WowLuaButton_Config,
		WowLuaButton_Previous,
		WowLuaButton_Next,
		WowLuaButton_Run,
	}

	for _, object in ipairs(Buttons) do
		E:CreateBackdrop(object)
		object:GetNormalTexture():SetTexCoord(.1, .92, .14, .92)
		if object:GetDisabledTexture() then
			object:GetDisabledTexture():SetTexCoord(.1, .92, .14, .92)
		end
		E:StyleButton(object, nil, true)
	end

	S:HandleNextPrevButton(WowLuaFrameOutputUpButton)
	S:SquareButton_SetIcon(WowLuaFrameOutputUpButton, "UP")
	WowLuaFrameOutputUpButton:SetWidth(18)
	WowLuaFrameOutputUpButton:SetHeight(18)

	S:HandleNextPrevButton(WowLuaFrameOutputDownButton)
	S:SquareButton_SetIcon(WowLuaFrameOutputDownButton, "DOWN")
	WowLuaFrameOutputDownButton:SetWidth(18)
	WowLuaFrameOutputDownButton:SetHeight(18)
end

S:AddCallbackForAddon("WowLuaVanilla", "WowLuaVanilla", LoadSkin)