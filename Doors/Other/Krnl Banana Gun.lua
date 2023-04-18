local Player = game.Players.LocalPlayer
local char = Player.Character
local hum = char:WaitForChild("Humanoid")
local Equipped = false
local Char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded
local Hum = Char:WaitForChild("Humanoid")
local Root = Char:WaitForChild("HumanoidRootPart")
local RightArm = Char:WaitForChild("RightUpperArm")
local LeftArm = Char:WaitForChild("LeftUpperArm")
local RightC1 = RightArm.RightShoulder.C1
local LeftC1 = LeftArm.LeftShoulder.C1
local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/MateiDaBest/Utilities/main/Doors/Custom%20Shop%20Items/Main.lua"))()
local BananaGun = game:GetObjects("rbxassetid://13125092275")[1]

CustomShop.CreateItem({
	Title = "Banana Gun",
	Desc = "#FE",
	Image = "https://cdn.discordapp.com/attachments/1035669085972856973/1096397678625161286/4682374.png",
	Price = "FREE",
	Stack = 1,
})

BananaGun.Parent = game.Players.LocalPlayer.Backpack

local function Shoot()
	local Banana = workspace:FindFirstChild("BananaPeel")
	local Sound = Instance.new("Sound", game.StarterPlayer)
	local HRP = BananaGun.Shoot.CFrame * CFrame.Angles(0,math.rad(-90),0)
	local Attachment = Instance.new("Attachment", Banana)
	local LV = Instance.new("LinearVelocity", Attachment)
	task.wait()
	Banana.Anchored = false
	Banana.Massless = false
	Sound.Volume = 10
	Sound.SoundId = "rbxassetid://4700679385"
	Sound.PlayOnRemove = true
	Sound:Destroy()
	LV.MaxForce = math.huge
	LV.VectorVelocity = (game:GetService("Players").LocalPlayer:GetMouse().Hit.Position - BananaGun.Shoot.Position).Unit * 100
	LV.Attachment0 = Attachment
	Banana.Parent = workspace
	Banana.CFrame = BananaGun.Shoot.CFrame * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
	
	Banana.Touched:Connect(function(part)
		local Model = part:FindFirstAncestorWhichIsA("Model")
		if Model.Name == "JeffTheKiller" then
			Model:FindFirstChild("Humanoid").Health = 0
			task.wait()
			Model:FindFirstChild("Humanoid").Health = 1
			task.wait()
			Model:FindFirstChild("Humanoid").Health = 0	
		end	
	end)
end

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
			* CFrame.new(-0.2, 0.5, -0.5)
			* CFrame.Angles(math.rad(-90), math.rad(25), math.rad(0))
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
		Shoot()
	end)
end

setupHands(BananaGun)
