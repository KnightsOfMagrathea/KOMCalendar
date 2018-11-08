print('LETS PRINT THE CALENDAR')

function printKeys(table)
   for k,v in pairs(table) do
      print(k .. ': ' .. tostring(v))
   end
end


function printEvent(event)
   if(event.eventType >= 0 and event.eventType <= 2) then
      print(string.format('%s at %02d:%02d on %02d/%02d/%04d run by %s', event.title, event.startTime.hour, event.startTime.minute, event.startTime.month, event.startTime.monthDay, event.startTime.year, event.invitedBy)); 
   end
end

for d=0, 31 do
   for i=1, C_Calendar.GetNumDayEvents(0,d) do 
      printEvent(C_Calendar.GetDayEvent(0,d,i))
   end
end
