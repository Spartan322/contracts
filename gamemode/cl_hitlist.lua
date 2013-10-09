local targetname
local targetkills = 0
local civkills = 0

local alive
local traitor

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
            draw.SimpleText("Kill " .. targetname, "HealthAmmo", 35, ScrH() - 220, Color(255, 0, 0, 255))
            draw.SimpleText("Killed Targets: " .. targetkills .. " | Killed Civilians: " .. civkills, "HealthAmmo", 35, 35, Color(255, 0, 0, 255))
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
    chat.AddText(Color(255, 0, 0), "You are a hitman, hired by a mysterious employer who wants a range of people dead. Avoid killing anyone else than the target or your employer will be ... unsatisfied.")
end
usermessage.Hook( "hitman_you_are_t", YouAreTraitor )


function Disappointed(um)
    chat.AddText(Color(255, 0, 0), "Your employer is very disappointed of your work and decided to activate the killswitch")
end
usermessage.Hook( "hitman_disappointed", Disappointed )
