local myname, ns = ...
local myfullname = C_AddOns.GetAddOnMetadata(myname, "Title")

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
--/script ServerRestart:CHAT_MSG_SYSTEM("CHAT_MSG_SYSTEM", IDLE_MESSAGE)
local realmTimer = 0
function ns:CHAT_MSG_SYSTEM(event, msg)
	if issecretvalue and issecretvalue(msg) then return end
	if msg == IDLE_MESSAGE then
		PlaySoundFile(543569, "Master") -- Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_Berzerk01.ogg
		return
	end
	if not msg:find("[SERVER]") then return end
	if GetTime() - realmTimer < 2 then return end
	realmTimer = GetTime()
	if msg:find("realm") and (msg:find("restart") and not msg:find("Cross") or msg:find("maintenance")) then
		--Message contains both "realm" and "restart" or "realm" and "maintenance" in same sentence it's probably the right message
		PlaySoundFile(544153, "Master") -- Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSDStart01.ogg
	elseif msg:find(" 10:00") then
		PlaySoundFile(544184, "Master") -- Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD10.ogg
	elseif msg:find(" 5:00") then
		PlaySoundFile(544189, "Master") -- Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD05.ogg
	elseif msg:find(" 3:00") then
		PlaySoundFile(544186, "Master") -- Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD03.ogg
	elseif msg:find(" 2:00") then
		PlaySoundFile(544152, "Master") -- Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD02.ogg
	elseif msg:find(" 1:00") then
		PlaySoundFile(544204, "Master") -- Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD01.ogg
	elseif msg:find(" 0:15") then
		PlaySoundFile(544176, "Master") -- Sound\\Creature\\ArchivumSystem\\UR_Archivum_MimironSD00.ogg
	end
end
ns:RegisterEvent("CHAT_MSG_SYSTEM")
