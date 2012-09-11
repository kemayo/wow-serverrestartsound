local myname, ns = ...
local myfullname = GetAddOnMetadata(myname, "Title")

ServerRestart = ns

-- debug
local debugf = tekDebug and tekDebug:GetFrame(myname)
function ns.Debug(...) if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end end
function ns.Print(...) print("|cFF33FF99".. myfullname.. "|r:", ...) end

-- events
local f = CreateFrame("frame")
f:SetScript("OnEvent", function(self, event, ...) if ns[event] then return ns[event](ns, event, ...) end end)
function ns:RegisterEvent(...) for i=1,select("#", ...) do f:RegisterEvent((select(i, ...))) end end
function ns:UnregisterEvent(...) for i=1,select("#", ...) do f:UnregisterEvent((select(i, ...))) end end

-- Actual functionality
--8/2 08:03:29.127  [SERVER] This realm is scheduled for a rolling restart. Thank you for your patience and understanding.
--8/2 08:03:35.504  [SERVER] Restart in 10:00
--8/2 08:03:35.504  [SERVER] Shutdown in 10:00
function ns:CHAT_MSG_SYSTEM(event, msg)
	if msg == IDLE_MESSAGE then
		PlaySoundFile("Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_Berzerk01.wav", "Master")
	end
	if not msg:find("[SERVER]") then return end
	if msg:find("realm") and (msg:find("restart") or msg:find("maintenance")) then
		PlaySoundFile("Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSDStart01.wav", "Master")
	elseif msg:find(" 10:00") then
		PlaySoundFile("Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD10.wav", "Master")
	elseif msg:find(" 5:00") then
		PlaySoundFile("Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD05.wav", "Master")
	elseif msg:find(" 3:00") then
		PlaySoundFile("Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD03.wav", "Master")
	elseif msg:find(" 2:00") then
		PlaySoundFile("Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD02.wav", "Master")
	elseif msg:find(" 1:00") then
		PlaySoundFile("Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD01.wav", "Master")
	elseif msg:find(" 0:15") then
		PlaySoundFile("Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD00.wav", "Master")
	end
end
ns:RegisterEvent("CHAT_MSG_SYSTEM")
