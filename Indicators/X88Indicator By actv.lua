local font = draw.CreateFont("Verdana", -11, 500, FONTFLAG_OUTLINE)
local current_fps = 0

playerName = steam.GetPlayerName( steam.GetSteamID() )
local function primary() 
    draw.SetFont(font)
    draw.Color(255, 255, 0, 255)
    draw.Text(70, 305, "Hello ActiveDistinct :)")
    draw.Text(200, 305, "FrameRate  " .. current_fps .. "")
    draw.Text(270 - 200, 25 + 300, "Hello "..playerName.." :)")
end


local function secondary()
    if (engine.IsGameUIVisible() == false) then
        local aimbot = gui.GetValue("aim bot")
        local aimbotMethod = gui.GetValue("aim method")
        local aimbotfov = gui.GetValue("aim fov")
        local dt = gui.GetValue("Double Tap")
        local dtTicks = warp.GetChargedTicks()
        local aa = gui.GetValue("anti aim")
        local chams = gui.GetValue("colored players")
        local esp = gui.GetValue("players")
        local fakepingvalue = gui.GetValue("fake latency value (ms)")
        local fakeping = gui.GetValue("fake latency")
        local triggerbot = gui.GetValue("trigger shoot")
        local bhop = gui.GetValue("bunny hop")
        local autostrafe = gui.GetValue("auto strafe")
        local nohands = gui.GetValue("no hands")
        local noscope = gui.GetValue("no scope")
        local customfov = gui.GetValue("enable custom fov")
        local fovvalue = gui.GetValue("custom fov value")
        local thirdperson = gui.GetValue("thirdperson")
        local triggerdel = gui.GetValue("trigger shoot delay (ms)")

        draw.Color(255, 255, 255, 255)
        if globals.FrameCount() % 50 == 0 then
            current_fps = math.floor(1 / globals.FrameTime())
        end
        if  engine.IsGameUIVisible() == false  then
            draw.Text(270 - 200 , 100 + 300, "Triggerbot: ")

            if (triggerbot == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(370 - 200, 100 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(370 - 200, 100 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(270 - 200, 85 + 300, "ESP: ")
            if (esp == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(370 - 200, 85 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(370 - 200, 85 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(270 - 200, 70 + 300, "AimFov: ")
            if (aimbotfov ~= 0) then
                draw.Color(0, 255, 0, 255)
                draw.Text(370 - 200, 70 + 300, aimbotfov)
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(370 - 200, 70 + 300, aimbotfov)
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 85 + 300, "Bunnyhop: ")
            if (bhop == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(500 - 200, 85 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 85 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(270 - 200, 55 + 300, "AimBot: ")

            if (aimbot == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(370 - 200, 55 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(370 - 200, 55 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 55 + 300, "AimMethod: ")
            if (aimbotMethod ~= 0) then
                draw.Color(0, 255, 0, 255)
                draw.Text(500 - 200, 55 + 300, aimbotMethod)
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 55 + 300, aimbotMethod)
            end

            if (aa == 1) then
                draw.Color(255, 0, 0, 255)
                draw.Text(270 - 200, 130 + 300, "AA: WARNING: ")
                draw.Text(370 - 200, 130 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(270 - 200, 130 + 300, "AA: ")
                draw.Text(370 - 200, 130 + 300, "OFF")
            end

            draw.Color(255, 255, 255, 255)
            draw.Text(400 - 200, 100 + 300, "AutoStrafe: ")

            if (autostrafe ~= 0) then
                draw.Color(0, 255, 0, 255)
                draw.Text(500 - 200, 100 + 300, autostrafe)
            else
                if (autostrafe == none) then
                    draw.Color(255, 255, 255, 255)
                    draw.Text(500 - 200, 100 + 300, "OFF")
                end
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 115 + 300, "NoScope: ")
            if (noscope == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(500 - 200, 115 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 115 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 130 + 300, "NoHands: ")

            if (nohands == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(500 - 200, 130 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 130 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 145 + 300, "FOVChanger: ")

            if (customfov == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(500 - 200, 145 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 145 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 160 + 300, "ViewFOV: ")

            if (fovvalue ~= 0) then
                draw.Color(0, 255, 0, 255)
                draw.Text(500 - 200, 160 + 300, fovvalue)
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 160 + 300, fovvalue)
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 175 + 300, "FakeLatency: ")

            if (fakeping == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(500 - 200, 175 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 175 + 300, "OFF")
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(400 - 200, 190 + 300, "Amount: ")
            if (fakepingvalue ~= 0) then
                draw.Color(0, 255, 0, 255)
                draw.Text(500 - 200, 190 + 300, fakepingvalue)
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 190 + 300, fakepingvalue)
            end
            draw.Color(255, 255, 255, 255)

            draw.Text(270 - 200, 115 + 300, "TriggerDelay: ")
            if (triggerdel ~= 0) then
                draw.Color(0, 255, 0, 255)
                draw.Text(370 - 200, 115 + 300, triggerdel)
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(370 - 200, 115 + 300, triggerdel)
            end
            draw.Color(255, 255, 255, 255)
            draw.Text(400 - 200, 70 + 300, "Thirdperson: ")
            if (thirdperson == 1) then
                draw.Color(0, 102, 255, 255)
                draw.Text(500 - 200, 70 + 300, "ON")
            else
                draw.Color(255, 255, 255, 255)
                draw.Text(500 - 200, 70 + 300, "OFF")
            end
else return end
end -- end of secondary function
end
callbacks.Register("Draw", primary)
callbacks.Register("Draw", "draw", secondary)