local customFont = draw.CreateFont("Arial", 16, 500, FONTFLAG_OUTLINE, 1)
local startTime = globals.RealTime()

callbacks.Register("Draw", function()
    if not engine.IsGameUIVisible() then
        draw.SetFont(customFont)
        local playerEntity = entities.GetLocalPlayer()
        local weaponEntity = playerEntity:GetPropEntity("m_hActiveWeapon")
        if weaponEntity ~= nil and playerEntity:IsAlive() then
            local tokenBucket = weaponEntity:GetCritTokenBucket()
            local critSeedRequestCount = weaponEntity:GetCritSeedRequestCount()
            local critCheckCount = weaponEntity:GetCritCheckCount()
            local critCost = weaponEntity:GetCritCost(tokenBucket, critSeedRequestCount, critCheckCount)
            local availableCrits = math.floor(tokenBucket / critCost)
            local infoText, infoDetail
            local critChance = weaponEntity:GetCritChance()
            local cmpCritChance = critChance + 0.1
            local playerTeam = playerEntity:GetTeamNumber()
            if playerTeam == 2 then
                draw.Color(255, 100, 100, 255)
            elseif playerTeam == 3 then
                draw.Color(100, 100, 255, 255)
            else
                draw.Color(255, 255, 255, 255)
            end
            if cmpCritChance > weaponEntity:CalcObservedCritChance() then
                infoText = "Crits"
                infoDetail = tostring(availableCrits)
            else
                local currentTime = globals.RealTime()
                local colorPhase = math.sin((currentTime - startTime) * 2) * 0.5 + 0.5
                local red = 255
                local green = math.floor(colorPhase * 255)
                local blue = 0
                draw.Color(red, green, blue, 255)
                local damageStats = weaponEntity:GetWeaponDamageStats()
                local totalDamage = damageStats["total"]
                local criticalDamage = damageStats["critical"]
                local requiredTotalDamage = (criticalDamage * (2.0 * cmpCritChance + 1.0)) / cmpCritChance / 3.0
                local requiredDamage = requiredTotalDamage - totalDamage
                infoText = "Crit Banned"
                infoDetail = math.floor(requiredDamage) .. " Damage"
            end
            local screenWidth, screenHeight = draw.GetScreenSize()
            local centerX, centerY = screenWidth / 2, screenHeight / 2 + 30
            local textWidth, textHeight = draw.GetTextSize(infoText)
            local detailWidth, detailHeight = draw.GetTextSize(infoDetail)
            draw.Text(math.floor(centerX - textWidth / 2), math.floor(centerY), infoText)
            draw.Color(255, 255, 255, 255)
            draw.Text(math.floor(centerX - detailWidth / 2), math.floor(centerY + textHeight + 5), infoDetail)
        end
    end
end)
