local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins");

-- DPSMate v130

local function LoadSkin()
	if not E.private.addOnSkins.DPSMate then return end

end

S:AddCallbackForAddon("DPSMate", "DPSMate", LoadSkin)