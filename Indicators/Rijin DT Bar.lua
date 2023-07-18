local smallestPixel = draw.CreateFont("Smallest Pixel", 11, 400, FONTFLAG_OUTLINE, 1)
local barWidth = 160
local barHeight = 15
local maxTicks = 23
local barOffset = 30 -- Adjust this value to move the bar further down

local function doDraw()
    if engine.Con_IsVisible() or engine.IsGameUIVisible() then
        return
    end

    local chargedTicks = warp.GetChargedTicks()
    chargedTicks = math.max(1, math.min(chargedTicks, maxTicks))

    local screenX, screenY = draw.GetScreenSize()
    local barX = math.floor(screenX / 2 - barWidth / 2)
    local barY = math.floor(screenY / 2) + barOffset

    -- Background
    draw.Color(28, 29, 38, 255)
    draw.FilledRect(barX, barY, barX + barWidth, barY + barHeight)

    -- Filled portion color based on chargedticks
    if chargedTicks == maxTicks then
        for i = 0, barWidth - 1 do
            local gradient = i / (barWidth - 1)
            local r = math.floor((1 - gradient) * 59 + gradient * 23)
            local g = math.floor((1 - gradient) * 66 + gradient * 165)
            local b = math.floor((1 - gradient) * 199 + gradient * 239)
            draw.Color(r, g, b, 255)
            draw.FilledRect(barX + i, barY, barX + i + 1, barY + barHeight)
        end
    else
        draw.Color(59, 66, 199, 255) -- Left gradient color
        draw.FilledRect(barX, barY, barX + math.floor(barWidth * chargedTicks / maxTicks), barY + barHeight)
    end

    -- Border
    draw.Color(36, 119, 198, 255)
    draw.OutlinedRect(barX, barY, barX + barWidth, barY + barHeight)

    -- Text
    local text = "CHARGE"
    local textWidth, textHeight = draw.GetTextSize(text)
    local textX = barX + 2
    local textY = barY - textHeight - -1

    draw.SetFont(smallestPixel)
    draw.Color(255, 255, 255, 255)
    draw.Text(textX, textY, text)

    -- DT State Text
    local dtStateText
    local dtStateColor

    if chargedTicks <= 1 then
        dtStateText = "NO CHARGE"
        dtStateColor = { 207, 51, 42, 255 }
    elseif chargedTicks >= 2 and chargedTicks <= 22 then
        dtStateText = "NOT ENOUGH CHARGE"
        dtStateColor = { 207, 51, 42, 255 }
    else
        dtStateText = "READY"
        dtStateColor = { 10, 188, 105, 255 }
    end

    local dtStateTextWidth, dtStateTextHeight = draw.GetTextSize(dtStateText)
    local dtStateTextX = barX + barWidth - dtStateTextWidth - 2
    local dtStateTextY = barY - dtStateTextHeight - -1

    draw.Color(dtStateColor[1], dtStateColor[2], dtStateColor[3], dtStateColor[4])
    draw.Text(dtStateTextX, dtStateTextY, dtStateText)
end

callbacks.Register("Draw", "mydraw", doDraw)
