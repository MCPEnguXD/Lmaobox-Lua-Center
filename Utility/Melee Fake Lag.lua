local distanceThreshold = 300

callbacks.Register("Draw", function()
    local localPlayer = entities.GetLocalPlayer()
    
    if localPlayer ~= nil and localPlayer:IsAlive() then
        local localPos = localPlayer:GetAbsOrigin()
        local localTeam = localPlayer:GetTeamNumber()
        local players = entities.FindByClass("CTFPlayer")
        local meleeEnemyNear = false
        
        for i, player in pairs(players) do
            if player ~= nil and player:IsAlive() and player:GetIndex() ~= localPlayer:GetIndex() and player:GetTeamNumber() ~= localTeam then
                local playerPos = player:GetAbsOrigin()
                local distance = (localPos - playerPos):Length()
                
                if distance <= distanceThreshold then
                    if player:GetPropEntity("m_hActiveWeapon") == player:GetEntityForLoadoutSlot(2) then
                        meleeEnemyNear = true
                        break
                    end
                end
            end
        end
        
        if meleeEnemyNear then
            gui.SetValue("fake lag", 1)
        else
            gui.SetValue("fake lag", 0)
        end
    end
end)
