local myfont = draw.CreateFont("Verdana", 16, 800)
local barWidth = 140
local barHeight = 15
local backgroundOffset = 5
local minTicks = 1
local maxTicks = 23

local function doDraw()
    if engine.Con_IsVisible() or engine.IsGameUIVisible() then
        return
    end

    local chargedTicks = warp.GetChargedTicks()
    chargedTicks = math.max(minTicks, math.min(chargedTicks, maxTicks))

    local screenX, screenY = draw.GetScreenSize()
    local barX = math.floor(screenX / 2 - barWidth / 2)
    local barY = math.floor(screenY / 2)

    -- Background
    draw.Color(70, 70, 70, 150)
    draw.FilledRect(barX - backgroundOffset, barY - backgroundOffset, barX + barWidth + backgroundOffset, barY + barHeight + backgroundOffset)

    -- Filled portion color based on chargedTicks
    local filledWidth = math.floor(barWidth * (chargedTicks - minTicks) / (maxTicks - minTicks))
    if chargedTicks == maxTicks then
        draw.Color(1, 221, 103, 255) -- Green
    else
        draw.Color(97, 97, 76, 255) -- Red
    end
    draw.FilledRect(barX, barY, barX + filledWidth, barY + barHeight)
end

callbacks.Register("Draw", "mydraw", doDraw)
