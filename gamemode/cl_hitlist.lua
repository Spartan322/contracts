local targetname
local targetkills = 0
local civkills = 0

local alive
local traitor

--for painting
local x = 270
local y = ScrH() - 130

local w = 200
local h = 120

function ReceiveTarget(um)
    targetname = um:ReadString()
end
usermessage.Hook( "hitman_newtarget", ReceiveTarget )

function NoTarget(um)
    targetname = nil
end
usermessage.Hook( "hitman_notarget", NoTarget )

function DisplayHitlistHUD()
    if targetname ~= nil then
        if alive == 1 then
		    --basic box
            draw.RoundedBox(8, x, y, w, h, Color(0, 0, 10, 200))
			draw.RoundedBox(8, x, y, w, 30, Color(200, 25, 25, 200))
			
			--Didn't mind using BadKings ShadowedText. For some reason stuff doesn't properly import. Got to clean up the bloody code at some point anyway.
			
			--Target announcer
			draw.SimpleText(targetname, "TraitorState", x + 12, y+2, Color(0, 0, 0, 255))
            draw.SimpleText(targetname, "TraitorState", x + 10, y, Color(255, 255, 255, 255))
			--Stats
            draw.SimpleText("Killed Targets: " .. targetkills, "HealthAmmo", x + 12, y +42, Color(0, 0, 0, 255))
			draw.SimpleText("Killed Targets: " .. targetkills, "HealthAmmo", x + 10, y +40, Color(255, 255, 255, 255))
			
			draw.SimpleText("Killed Civilians: " .. civkills, "HealthAmmo", x + 12, y + 62, Color(0, 0, 0, 255))
            draw.SimpleText("Killed Civilians: " .. civkills, "HealthAmmo", x + 10, y + 60, Color(255, 255, 255, 255))
        end
    end
end
hook.Add("HUDPaint", "DisplayHitlistHUD", DisplayHitlistHUD);
--Fetch stats
function SetTargetKills(um)
    targetkills = um:ReadShort()
end
usermessage.Hook( "hitman_killed_targets", SetTargetKills )

function SetCivKills(um)
    civkills = um:ReadShort()
end
usermessage.Hook( "hitman_killed_civs", SetCivKills )
--Fetch condition, so the Display can work properly
function SetAlive(um)
    alive = 1
    print("You are now set as Alive")
end
usermessage.Hook( "hitman_alive", SetAlive )

function SetDead(um)
    alive = 0
end
usermessage.Hook( "hitman_dead", SetDead )

function YouAreTraitor(um)
    chat.AddText(Color(255, 0, 0), "You are a hitman, hired by a mysterious employer who wants a range of people dead. Avoid killing anyone other than the target or your employer will be ... unsatisfied.")
end
usermessage.Hook( "hitman_you_are_t", YouAreTraitor )


function Disappointed(um)
    chat.AddText(Color(255, 0, 0), "Your employer is very disappointed of your work and decided to activate the killswitch")
end
usermessage.Hook( "hitman_disappointed", Disappointed )