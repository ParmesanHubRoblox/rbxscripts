repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

if game.PlaceId ~= 17579225831 then TeleportService:Teleport(17579225831); script.Enabled = false end

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Platform = game.Workspace:FindFirstChild("Platform")

local BricksLabel = LocalPlayer.PlayerGui.ScreenGui.UnderPopUpFrame.RetroGuiTopMenu.TopMenuFrame2.BrickLabel
local Floor = game.Workspace.ClassicMinigame.ClassicBaseplate
local TycoonButtons = game.Workspace.ClassicMinigame.TycoonButtons

game.Workspace.Collectibles:ClearAllChildren()

for _, v in Character:GetDescendants() do
	if v:IsA("BasePart") then v.CanCollide = false end
end

if Platform == nil then
	Platform = Instance.new("Part", game.Workspace)
	Platform.Anchored = true
	Platform.Size = Vector3.new(10, 0.5, 10)
	Platform.Name = "Platform"
end

local IgnoreTokens = {}

local function FindClosestToken(Tokens, HumanoidRootPart)
	local ClosestDistance = math.huge
	local ClosestToken = nil

	for _, Token in pairs(Tokens:GetChildren()) do
		if table.find(IgnoreTokens, Token) then continue end

		local CurrentDistance = (HumanoidRootPart.Position - Token.Position).Magnitude
		if CurrentDistance < ClosestDistance then
			ClosestDistance = CurrentDistance
			ClosestToken = Token
		end
	end

	if ClosestToken ~= nil then table.insert(IgnoreTokens, ClosestToken) end

	return ClosestDistance / 75, ClosestToken
end

local function IsMonsterOnFloor(Monster)
	if not Monster:FindFirstChild("MonsterType") or not Monster:FindFirstChild("HumanoidRootPart") then return end

	local FloorTopPos = Floor.Position.Y + Floor.Size.Y / 2

	if Monster.MonsterType.Value == "Slime" then
		if not Monster:FindFirstChild("SlimeMonster") then return end
		local SlimeBottomPos = Monster.HumanoidRootPart.Position.Y - Monster.SlimeMonster.Blob2.Size.Y / 2
		return (SlimeBottomPos - FloorTopPos) <= 1
	elseif Monster.MonsterType.Value == "Zombie" then
		local ZombieBottomPos = Monster.HumanoidRootPart.Position.Y - 3.75
		return (ZombieBottomPos - FloorTopPos) <= 1
	end

	return nil
end

local CurrentItems = {
	[1] = {Name = "Buy Classic Sword", Cost = 10, Owned = false},
	[2] = {Name = "Buy Firebrand", Cost = 300, Owned = false},
	[3] = {Name = "Buy Illumina", Cost = 1500, Owned = false},
	[4] = {Name = "Buy Bloxiade", Cost = 100, Owned = false},
	[5] = {Name = "Buy Bloxy Cola", Cost = 200, Owned = false},
	[6] = {Name = "Buy Chez Burger", Cost = 300, Owned = false},
	[7] = {Name = "Buy Pizza", Cost = 500, Owned = false},
}

local TokenTween

local function CheckItems(CurrentBricks)
	for index = 1, 7, 1 do
		local ItemData = CurrentItems[index]
		if ItemData.Owned == true then continue end
		if ItemData.Cost > CurrentBricks then return end

		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

		while TycoonButtons[ItemData.Name].Button.Color ~= Color3.fromRGB(0, 255, 0) do
			RunService.RenderStepped:Wait()
		end

		if TokenTween then TokenTween:Pause(); TokenTween = nil end

		while TycoonButtons[ItemData.Name].Button.Color ~= Color3.fromRGB(199, 39, 28) do
			HumanoidRootPart.CFrame = CFrame.new(TycoonButtons[ItemData.Name].Button.Position + Vector3.new(0, 3.75, 0))
			RunService.RenderStepped:Wait()
		end

		CurrentItems[index].Owned = true

		break
	end
end

while true and task.wait() do
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	local Tool = Character:FindFirstChildOfClass("Tool")
	
	local ModifiedString = string.gsub(BricksLabel.Text, ",", "")
	local CurrentBricks = tonumber(ModifiedString)

	CheckItems(CurrentBricks)

	local Monsters = game.Workspace.Monsters:GetChildren()

	if #Monsters ~= 0 then
		HumanoidRootPart.Anchored = true
		Platform.Position = Vector3.new(-47064, 305, -89)
		HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-47064, 307, -89))
		if Tool and Tool:FindFirstChild("SwordPart") then Tool.SwordPart.Size = Vector3.new(1000, 1000, 0.1) end
	elseif #Monsters == 0 and CurrentItems[7].Owned == false then
		local FlyTime, Token = FindClosestToken(game.Workspace.Collectibles, HumanoidRootPart)

		if Token then
			TokenTween = TweenService:Create(
				HumanoidRootPart,
				TweenInfo.new(FlyTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false),
				{CFrame = CFrame.new(Token.Position)}
			)

			TokenTween:Play(); TokenTween.Completed:Wait()
		end
	end
end
