-- The function for the OnLoad event
function KOMC_OnLoad(self, event, ...)
	self:RegisterEvent("ADDON_LOADED") -- Tells the addon that it's finished loading
end

-- The function to handle events
function KOMC_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" and ... == "KOMCalendar" then
		self:UnregisterEvent("ADDON_LOADED")
		if calendar == nil then -- If the saved variable does not exist yet, define it
			calendar = {}
		end
	end
end

-- Converts a date and time to a unix timestamp
function unixTimestamp(year, month, day, hour, minute)
	return time{year=year, month=month, day=day, hour=hour, min=minute}
end

-- Formats and prints the info about an event if it's a guild event
function printEvent(event)
	print(string.format('%s at %02d:%02d on %02d/%02d/%04d run by %s',
		event.title, 
		event.startTime.hour, 
		event.startTime.minute, 
		event.startTime.month, 
		event.startTime.monthDay, 
		event.startTime.year, 
		event.invitedBy))
end

-- The structure of the calendar table will look something like this
-- calendar = {
-- 		[<timestamp>] = {
--			["title"] = "foo",
--			["creator"] = "bar",
--			...
--		},
--		...
-- }

-- Gets all guild events from this month on the calendar and
-- adds an entry to the calendar table
-- Note: the calendar table won't save to disk until you /reload or logout/exit the game.
function getEvents()
	for day = 0, 31 do
		for item = 1, C_Calendar.GetNumDayEvents(0, day) do
			event = C_Calendar.GetDayEvent(0, day, item)
			if(event.eventType >= 0 and event.eventType <= 2) then -- Make sure it's a guild event
				printEvent(event)
				eventTimestamp = unixTimestamp(
					event.startTime.year,
					event.startTime.month, 
					event.startTime.monthDay, 
					event.startTime.hour, 
					event.startTime.minute)
				calendar[eventTimestamp] = {
					["title"] = event.title,
					["creator"] = event.invitedBy
				}
			end
		end
	end
end

-- Define the slash-command
SLASH_KOMC1 = "/komc"
function SlashCmdList.KOMC()
	getEvents() -- Get the list of guild events when the user types "/komc"
end