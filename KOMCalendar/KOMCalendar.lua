function KOMC_OnLoad(self, event, ...)
	self:RegisterEvent("ADDON_LOADED")
end

function KOMC_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" and ... == "KOMCalendar" then
		self:UnregisterEvent("ADDON_LOADED")
	end
end


