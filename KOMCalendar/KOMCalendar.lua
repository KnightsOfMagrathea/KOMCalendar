-- The function for the OnLoad event
function KOMC_OnLoad(self, event, ...)
	self:RegisterEvent("ADDON_LOADED") -- Tells the addon that it's finished loading
end

-- The function to handle events
function KOMC_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" and ... == "KOMCalendar" then
		self:UnregisterEvent("ADDON_LOADED")
	end
end

-- Formats and prints the info about an event if it's a guild event
function printEvent(event)
   if(event.eventType >= 0 and event.eventType <= 2) then
      print(string.format('%s at %02d:%02d on %02d/%02d/%04d run by %s',
		event.title, 
		event.startTime.hour, 
		event.startTime.minute, 
		event.startTime.month, 
		event.startTime.monthDay, 
		event.startTime.year, 
		event.invitedBy))
   end
end

-- Define the slash-command
SLASH_KOMC1 = "/komc"
function SlashCmdList.KOMC()
	for day = 0, 31 do
		for i = 1, C_Calendar.GetNumDayEvents(0, day) do
			printEvent(C_Calendar.GetDayEvent(0, day, i))
		end
	end
end