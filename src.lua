-- MADE BY YOU WILL DIE :thumbsup: open source

-- helper function because fucking lua sucks dick
function isInTable(tbl:{}, value:any)
    for _, v in ipairs(tbl) do
        if v == value then return true end
    end
    return false
end

data = game.Players.LocalPlayer.Data
-- optimize blacklist from 96 lines to fucking 13
blacklist = {}

mats = {"Wood", "Titanium", "Rusted", "Plastic", "Obsidian", "Metal", "Marble", "Ice", "Gold", "Grass", "Glass", "Fabric", "Concrete", "Cane", "Brick"}
Axis = {"X", "Y", "Z", "XY", "XZ", "YZ"}

for _, material in ipairs(mats) do
    for _, axis in ipairs(Axis) do
        table.insert(blacklist, material.."Block"..axis)
    end
end

table.insert(blacklist, "PaintingTool")
table.insert(blacklist, "BindTool")
table.insert(blacklist, "ScalingTool")
table.insert(blacklist, "PropertiesTool")
table.insert(blacklist, "TrowelTool")
table.insert(blacklist, "Used") -- wanna skip that

for _, this in ipairs(data:GetDescendants()) do
    if this:IsA("IntValue") and not isInTable(blacklist, this.Name) then
        this.Value = 9999999 -- bruh
    --[[elseif this:IsA("IntValue") and this.Name in tools then
        this.Value = 1          --no :)--]]--
        task.wait(5)
        game.Players.LocalPlayer.Character:BreakJoints() -- auto kill
    end
end
