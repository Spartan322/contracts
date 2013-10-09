local targetname

function ReceiveTarget(um)
    targetname = um:ReadString()
end
usermessage.Hook( "hitman_newtarget", ReceiveTarget )

function NoTarget(um)
    targetname = nil
end
usermessage.Hook( "hitman_notarget", NoTarget )

function DisplayTarget()
    if targetname ~= nil then
        draw.SimpleText("Kill " .. targetname, "HealthAmmo", 40, ScrH() - 170, Color(255, 0, 0, 255))
    end
end
hook.Add("HUDPaint", "DisplayTarget", DisplayTarget);