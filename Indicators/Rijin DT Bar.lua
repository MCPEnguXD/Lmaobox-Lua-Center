local smallestPixel = draw.CreateFont("Smallest Pixel", 11, 400, FONTFLAG_OUTLINE, 1)
local barWidth = 160
local barHeight = 15
local maxTicks = 23
local barOffset = 30 -- Adjust this value to move the bar further down


local function clamp(a,b,c)return(a<b)and b or(a>c)and c or a end

local charge = 0;
local charging = false;
local updateBarCharge = (function()
    local last_charge = 0;

    return function()
        local max = clamp((client.GetConVar("sv_maxusrcmdprocessticks") or 23) - 2, 1, 21);
        charge = clamp((warp.GetChargedTicks() - 1) / 22, 0, 1);
        charging = charge > last_charge;

        last_charge = charge;
    end
end)();

callbacks.Register("Draw", function()
    if engine.Con_IsVisible() or engine.IsGameUIVisible() then
        return
    end

    draw.SetFont(smallestPixel)

    local screenX, screenY = draw.GetScreenSize()
    local barX = math.floor(screenX / 2 - barWidth / 2)
    local barY = math.floor(screenY / 2) + barOffset

    -- Background
    draw.Color(28, 29, 38, 255)
    draw.FilledRect(barX, barY, barX + barWidth, barY + barHeight)

    -- Bar gradient
    if charge ~= 0 then
        draw.Color(59, 66, 199, 255)
        draw.FilledRect(barX, barY, barX + math.floor(charge * barWidth), barY + barHeight)

        draw.Color(23, 165, 239, 255)
        draw.FilledRectFade(barX, barY, barX + math.floor(charge * barWidth), barY + barHeight, 0, math.floor(math.sin(globals.CurTime()*1.5) * 100 + 155), true)
    end

    -- Border
    draw.Color(36, 119, 198, 255)
    draw.OutlinedRect(barX, barY, barX + barWidth, barY + barHeight)

    -- Text
    local textWidth, textHeight = draw.GetTextSize("CHARGE")
    draw.Color(255, 255, 255, 255)
    draw.Text(barX + 2, barY - textHeight + 1, "CHARGE")

    -- DT State Text
    local dtStateText = "READY";

    if charge == 0 then
        dtStateText = "NO CHARGE";
        draw.Color(207, 51, 42, 255)

    elseif charging then
        dtStateText = "CHARGING";
        draw.Color(255, 168, 29, 255)

    elseif charge ~= 1 then
        dtStateText = "NOT ENOUGH CHARGE";
        draw.Color(207, 51, 42, 255)

    else
        draw.Color(10, 188, 105, 255)

    end

    local dtStateTextWidth, dtStateTextHeight = draw.GetTextSize(dtStateText);

    draw.Text(barX + barWidth - dtStateTextWidth - 2, barY - dtStateTextHeight + 1, dtStateText)
end)


callbacks.Register("CreateMove", function(cmd)
    updateBarCharge()
end)
