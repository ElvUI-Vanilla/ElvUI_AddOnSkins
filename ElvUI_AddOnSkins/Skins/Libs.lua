local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

local _G = _G
local select = select

AS.skinnedLibs = {}

local dewdropEditBoxFrame
local dewdropSliderFrame

local function SkinDewdrop2()
	local frame
	local i = 1

	while _G["Dewdrop20Level"..i] do
		frame = _G["Dewdrop20Level"..i]

		if not frame.isSkinned then
			E:SetTemplate(frame, "Transparent")

			select(1, frame:GetChildren()):Hide()
			frame.SetBackdropColor = E.noop
			frame.SetBackdropBorderColor = E.noop

			frame.isSkinned = true
		end

		i = i + 1
	end

	i = 1
	while _G["Dewdrop20Button" .. i] do
		if not _G["Dewdrop20Button" .. i].isHook then
			HookScript(_G["Dewdrop20Button" .. i], "OnEnter", function(self)
				if not self.disabled and self.hasArrow then
					if not dewdropEditBoxFrame and self.hasEditBox then
						dewdropEditBoxFrame = AS:FindFrameBySizeChild({"EditBox"}, 200, 40)

						if dewdropEditBoxFrame then
							E:SetTemplate(dewdropEditBoxFrame, "Transparent")
							S:HandleEditBox(dewdropEditBoxFrame.editBox)
							dewdropEditBoxFrame.editBox:DisableDrawLayer("BACKGROUND")
						end
					end
					if not dewdropSliderFrame and self.hasSlider then
						dewdropSliderFrame = AS:FindFrameBySizeChild({"Slider", "EditBox"}, 100, 170)

						if dewdropSliderFrame then
							E:SetTemplate(dewdropSliderFrame, "Transparent")
							S:HandleSliderFrame(dewdropSliderFrame.slider)
							S:HandleEditBox(dewdropSliderFrame.currentText)
							dewdropSliderFrame.currentText:DisableDrawLayer("BACKGROUND")
						end
					end

					SkinDewdrop2()
				end
			end)
			_G["Dewdrop20Button" .. i].isHook = true
		end

		i = i + 1
	end
end

local function SkinTablet2(lib)
	local function SkinDetachedFrame(self, fakeParent, parent)
		if not parent then
			parent = fakeParent
		end
		if self.registry[parent].data.detached then
			local frame
			local i = 1

			while _G["Tablet20DetachedFrame" .. i] do
				frame = _G["Tablet20DetachedFrame" .. i]

				if not frame.isSkinned then
					E:SetTemplate(frame, "Transparent")
					S:HandleSliderFrame(frame.slider)

					frame.isSkinned = true
				end

				i = i + 1
			end
		end
	end

	if not S:IsHooked(lib, "Open") then
		S:SecureHook(lib, "Open", function(self, fakeParent, parent)
			E:SetTemplate(_G["Tablet20Frame"], "Transparent")
			SkinDetachedFrame(self, fakeParent, parent)
		end)
	end

	if not S:IsHooked(lib, "Detach") then
		S:SecureHook(lib, "Detach", function(self, parent)
			SkinDetachedFrame(self, parent)
		end)
	end
end

local function SkinRockConfig(lib)
	local function SkinMainFrame(self)
		if self.base.isSkinned then return end

		E:SetTemplate(self.base, "Transparent")
		E:StripTextures(self.base.header)
		S:HandleCloseButton(self.base.closeButton, self.base)

		E:SetTemplate(self.base.treeView, "Transparent")
		S:HandleScrollBar(self.base.treeView.scrollBar)
		S:HandleDropDownBox(self.base.addonChooser)

		E:Height(self.base.addonChooser.text, 20)
		E:SetTemplate(self.base.addonChooser.text, "Transparent")
		S:HandleNextPrevButton(self.base.addonChooser.button, true)

		local pullout = _G[self.base.mainPane:GetName().."_ChoicePullout"]
		if pullout then
			E:SetTemplate(pullout, "Transparent")
		else
			S:SecureHookScript(self.base.addonChooser.button, "OnClick", function(self)
				E:SetTemplate(_G[lib.base.mainPane:GetName().."_ChoicePullout"], "Transparent")
				S:Unhook(self, "OnClick")
			end)
		end

		E:SetTemplate(self.base.mainPane, "Transparent")
		S:HandleScrollBar(self.base.mainPane.scrollBar)

		E:SetTemplate(self.base.treeView.sizer, "Transparent")

		self.base.isSkinned = true
	end

	S:SecureHook(lib, "OpenConfigMenu", function(self)
		SkinMainFrame(self)
		S:Unhook(self, "OpenConfigMenu")
	end)

	local LR = LibStub("LibRock-1.0", true)
	if LR then
		for object in LR:IterateMixinObjects("LibRockConfig-1.0") do
			if not S:IsHooked(object, "OpenConfigMenu") then
				S:SecureHook(object, "OpenConfigMenu", function(self)
					SkinMainFrame(lib)
					S:Unhook(self, "OpenConfigMenu")
				end)
			end
		end
	end
end

function AS:SkinLibrary(name)
	if not name then return end
	if self.skinnedLibs[name] then return end

	if name == "AceAddon-2.0" then
		local AceAddon = LibStub("AceAddon-2.0", true)
		if AceAddon then
			S:SecureHook(AceAddon.prototype, "PrintAddonInfo", function()
				E:SetTemplate(AceAddon20AboutFrame, "Transparent")
				S:HandleButton(AceAddon20AboutFrameButton)
				S:HandleButton(AceAddon20AboutFrameDonateButton)

				S:Unhook(AceAddon.prototype, "PrintAddonInfo")
			end)
			S:SecureHook(AceAddon.prototype, "OpenDonationFrame", function()
				E:SetTemplate(AceAddon20Frame, "Transparent")
				S:HandleScrollBar(AceAddon20FrameScrollFrameScrollBar)
				S:HandleButton(AceAddon20FrameButton)

				S:Unhook(AceAddon.prototype, "OpenDonationFrame")
			end)
			self.skinnedLibs[name] = true
		end
	elseif name == "Dewdrop-2.0" then
		local Dewdrop = LibStub("Dewdrop-2.0", true)
		if Dewdrop and not S:IsHooked(Dewdrop, "Open") then
			S:SecureHook(Dewdrop, "Open", SkinDewdrop2)
			self.skinnedLibs[name] = true
		end
	elseif name == "Tablet-2.0" then
		local Tablet = LibStub("Tablet-2.0", true)
		if Tablet then
			SkinTablet2(Tablet)
			self.skinnedLibs[name] = true
		end
	elseif name == "LibExtraTip-1" then
		local LibExtraTip = LibStub("LibExtraTip-1", true)
		if LibExtraTip and not S:IsHooked(LibExtraTip, "GetFreeExtraTipObject") then
			S:RawHook(LibExtraTip, "GetFreeExtraTipObject", function(self)
				local tooltip = S.hooks[self].GetFreeExtraTipObject(self)

				if not tooltip.isSkinned then
					E:SetTemplate(tooltip, "Transparent")
					tooltip.isSkinned = true
				end

				return tooltip
			end)
			self.skinnedLibs[name] = true
		end
	elseif name == "LibRockConfig-1.0" then
		local LRC = LibStub("LibRockConfig-1.0", true)
		if LRC then
			SkinRockConfig(LRC)
			self.skinnedLibs[name] = true
		end
	elseif name == "ZFrame-1.0" then
		local LZF = LibStub("ZFrame-1.0", true)
		if LZF and not S:IsHooked(LZF, "Create") then
			S:RawHook(LZF, "Create", function(self, ...)
				local frame = S.hooks[self].Create(self, unpack(arg))

				E:SetTemplate(frame.ZMain, "Transparent")
				E:Size(frame.ZMain.close, 32)
				S:HandleCloseButton(frame.ZMain.close, frame.ZMain)

				return frame
			end, true)
		end
		self.skinnedLibs[name] = true
	end
end