local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local captureBarCreate, captureBarUpdate
local function LoadSkin()
	captureBarCreate = function(id)
		local bar = _G["WorldStateCaptureBar"..id]
		E:Size(bar, 173, 16)
		bar:ClearAllPoints()
		E:Point(bar, "CENTER", UIParent, "CENTER", 0, 360)
		E:CreateBackdrop(bar, "Default")

		E:Size(_G["WorldStateCaptureBar"..id.."LeftBar"], 85, 16)
		E:Point(_G["WorldStateCaptureBar"..id.."LeftBar"], "LEFT", 0, 0)
		_G["WorldStateCaptureBar"..id.."LeftBar"]:SetTexture(E.media.glossTex)
		_G["WorldStateCaptureBar"..id.."LeftBar"]:SetTexCoord(1, 0, 1, 0)
		_G["WorldStateCaptureBar"..id.."LeftBar"]:SetVertexColor(0, .44, .87)

		bar.leftBarIcon = bar:CreateTexture("$parentLeftBarIcon", "ARTWORK")
		bar.leftBarIcon:SetTexture("Interface\\AddOns\\ElvUI_AddOnSkins\\Media\\alliance")
		E:Point(bar.leftBarIcon, "RIGHT", bar, "LEFT", 0, 0)
		E:Size(bar.leftBarIcon, 32, 32)

		E:Size(_G["WorldStateCaptureBar"..id.."RightBar"], 85, 16)
		E:Point(_G["WorldStateCaptureBar"..id.."RightBar"], "RIGHT", 0, 0)
		_G["WorldStateCaptureBar"..id.."RightBar"]:SetTexture(E.media.glossTex)
		_G["WorldStateCaptureBar"..id.."RightBar"]:SetTexCoord(1, 0, 1, 0)
		_G["WorldStateCaptureBar"..id.."RightBar"]:SetVertexColor(.77, .12, .23)

		bar.rightBarIcon = bar:CreateTexture("$parentRightBarIcon", "ARTWORK")
		bar.rightBarIcon:SetTexture("Interface\\AddOns\\ElvUI_AddOnSkins\\Media\\horde")
		E:Point(bar.rightBarIcon, "LEFT", bar, "RIGHT", 0, 0)
		E:Size(bar.rightBarIcon, 32, 32)

		E:Size(_G["WorldStateCaptureBar"..id.."MiddleBar"], 25, 16)
		_G["WorldStateCaptureBar"..id.."MiddleBar"]:SetTexture(E.media.glossTex)
		_G["WorldStateCaptureBar"..id.."MiddleBar"]:SetTexCoord(1, 0, 1, 0)
		_G["WorldStateCaptureBar"..id.."MiddleBar"]:SetVertexColor(1, 1, 1)

		select(4, bar:GetRegions()):SetTexture(nil)

		_G["WorldStateCaptureBar"..id.."IndicatorLeft"]:SetTexture(nil)
		_G["WorldStateCaptureBar"..id.."IndicatorRight"]:SetTexture(nil)

		_G["WorldStateCaptureBar"..id.."LeftIconHighlight"]:SetTexture(nil)
		_G["WorldStateCaptureBar"..id.."RightIconHighlight"]:SetTexture(nil)

		E:StripTextures(_G["WorldStateCaptureBar"..id.."Indicator"])

		bar.spark = CreateFrame("Frame", "$parentSpark", bar)
		E:SetTemplate(bar.spark, "Default", true)
		E:Size(bar.spark, 4, 18)
	end

	captureBarUpdate = function(id, value, neutralPercent)
		local position = 173*(1 - value/100)
		local bar = _G["WorldStateCaptureBar"..id]
		local barSize = 170
		if not bar.oldValue then
			bar.oldValue = position
		end

		local middleBar = _G["WorldStateCaptureBar"..id.."MiddleBar"]
		if neutralPercent == 0 then
			E:Width(middleBar, 1)
		else
			E:Width(middleBar, neutralPercent/100*barSize)
		end
		bar.oldValue = position
		if bar.spark then
			E:Point(bar.spark, "CENTER", "WorldStateCaptureBar"..id, "LEFT", position, 0)
		else
			captureBarCreate(id)
		end
	end

	hooksecurefunc(ExtendedUI["CAPTUREPOINT"], "create", captureBarCreate)
	hooksecurefunc(ExtendedUI["CAPTUREPOINT"], "update", captureBarUpdate)
end

S:AddCallback("WorldStateFrame", LoadSkin)