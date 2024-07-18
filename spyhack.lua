-- helper function because fucking lua sucks dick
function isInTable(tbl:{}, value:any)
    for _, v in ipairs(tbl) do
        if v == value then return true end
    end
    return false
end

function printf(...:T) print(`================> {...} <================`) end
function has(this) return tonumber(this) ~= 0 end -- 0 IQ

plrs = game:GetService("Players")
CurrentPlayers = plrs:GetPlayers()

blacklist = {}

mats = {"Wood", "Titanium", "Rusted", "Plastic", "Obsidian", "Metal", "Marble", "Ice", "Gold", "Grass", "Glass", "Stone", "Fabric", "Concrete", "Cane", "Brick"}
Axis = {"X", "Y", "Z", "XY", "XZ", "YZ"}

for _, material in ipairs(mats) do
    for _, axis in ipairs(Axis) do
        table.insert(blacklist, material.."Block"..axis)
    end
end

tools = {"PaintingTool", "BindTool", "ScalingTool", "PropertiesTool", "TrowelTool"}

for _ in ipairs(CurrentPlayers) do -- loop through every player in the game
    for _, plr in ipairs(CurrentPlayers) do
        data = plr.Data
        printf(plr.Name)
        for _, this in ipairs(data:GetDescendants()) do
            if this:IsA("IntValue") then
                if not isInTable(blacklist, this.Name) and not isInTable(tools, this.Name) then
                    print(`{this.Name}: {this.Value}`)
                elseif isInTable(tools, this.Name) then
                    print(`{this.Name}: {has(this.Value)}`)
                end
            end
        end
        printf("DONE")
    end
end
