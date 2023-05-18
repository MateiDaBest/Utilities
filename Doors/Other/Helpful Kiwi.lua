local Players = game:GetService("Players")
local Equipped = false
local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local Root = Char:WaitForChild("HumanoidRootPart")
local RightArm = Char:WaitForChild("RightUpperArm")
local LeftArm = Char:WaitForChild("LeftUpperArm")
local RightC1 = RightArm.RightShoulder.C1
local LeftC1 = LeftArm.LeftShoulder.C1
local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/MateiDaBest/Utilities/main/Doors/Custom%20Shop%20Items/Main.lua"))()
local Tool = game:GetObjects("rbxassetid://13478866141")[1]
local Handle = Tool:WaitForChild("Handle")
local keyName = "KeyObtain"
local leverName = "LeverForGate"
local RNG = math.random(0, 10)

if RNG == 0 then
	Tool.Hat.Transparency = 0
end

local function StartPathfinding()
	local key = nil
	local lever = nil

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj.Name == keyName then
			key = obj
			break
		end
	end
	
	for _, obj in pairs(workspace:GetDescendants()) do
		if lever.Name == leverName then
			key = obj
			break
		end
	end

	if key then
		local RealKey = key:FindFirstChild("Hitbox")
		local H = Instance.new("Highlight")
		H.FillColor = Color3.fromRGB(255, 85, 0)
		H.FillTransparency = 0.5
		H.OutlineColor = Color3.fromRGB(0, 161, 0)
		H.OutlineTransparency = 0
		H.Parent = RealKey.Parent
		task.wait(7.5)
		H:Destroy()
	elseif lever then
		local H = Instance.new("Highlight")
		H.FillColor = Color3.fromRGB(255, 85, 0)
		H.FillTransparency = 0.5
		H.OutlineColor = Color3.fromRGB(0, 161, 0)
		H.OutlineTransparency = 0
		H.Parent = lever
		task.wait(7.5)
		H:Destroy()
	end
end

CustomShop.CreateItem({
	Title = "Kiwi Bird",
	Desc = "Your most helpful, but fightless bird!",
	Image = "http://www.roblox.com/asset/?id=13278244202",
	Price = "FREE",
	Stack = 1,
})

Tool.Parent = game.Players.LocalPlayer.Backpack

local function setupHands(tool)
	tool.Equipped:Connect(function()
		Equipped = true
		Char:SetAttribute("Hiding", true)
		for _, v in next, Hum:GetPlayingAnimationTracks() do
			v:Stop()
		end

		RightArm.Name = "R_Arm"
		LeftArm.Name = "L_Arm"

		RightArm.RightShoulder.C1 = RightC1
			* CFrame.Angles(math.rad(-90), math.rad(-10), 0)
		LeftArm.LeftShoulder.C1 = LeftC1
			* CFrame.new(-0.2, -0.1, -0.5)
			* CFrame.Angles(math.rad(-100), math.rad(30), math.rad(0))
	end)

	tool.Unequipped:Connect(function()
		Equipped = false
		Char:SetAttribute("Hiding", nil)
		RightArm.Name = "RightUpperArm"
		LeftArm.Name = "LeftUpperArm"

		RightArm.RightShoulder.C1 = RightC1
		LeftArm.LeftShoulder.C1 = LeftC1
	end)
	
	tool.Activated:Connect(function()		
		StartPathfinding()
	end)
end

setupHands(Tool)

while task.wait() do
	local rush = workspace:FindFirstChild("RushMoving") or workspace:FindFirstChild("AmbushMoving") or workspace.CurrentCamera:FindFirstChild("Screech")
	task.wait()
	if rush then
		for i,child in pairs(rush:GetChildren()) do
			if child:IsA("Part") and child.Name ~= "Part" then
				rushbody = child
			end
		end
		if rushbody and rushbody.CFrame.Y >= -9999 then
			local Char = game.Players.LocalPlayer.Character
			Handle.Danger:Play()
			repeat
				wait()
				checkforrush = game.Workspace:FindFirstChild("RushMoving")
				checkforambush = game.workspace:FindFirstChild("AmbushMoving")
				Char.Humanoid.WalkSpeed = 21
			until not checkforrush and not checkforambush
			task.wait()
			Char.Humanoid.WalkSpeed = 16
		end
	end
end