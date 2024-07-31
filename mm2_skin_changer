local range = {
  min = 1,
  max = 50
}

local db, pd = getrenv()._G.Database, getrenv()._G.PlayerData
local newOwned = {}

for i, _ in next, db.Item do
  newOwned[i] = math.random(range.min, range.max) -- newOwned[Weapon]: ItemCount
end

local weapons = pd.Weapons

game:GetService("RunService"):BindToRenderStep("InventoryUpdate", 0, function()
  weapons.Owned = newOwned
end)

game.Players.LocalPlayer.Character:BreakJoints() -- reset
