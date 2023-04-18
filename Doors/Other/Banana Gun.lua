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
local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/MateiDaBest/Utilities/main/Doors/Custom%20Shop%20Items/Main.lua", true))()
local BananaGun = game:GetObjects("rbxassetid://13161656565")[1]
local mouse = Player:GetMouse()

local Mobile = Instance.new("ScreenGui")
local Click = Instance.new("TextButton")

Mobile.Name = "Mobile"
Mobile.Enabled = false
Mobile.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Mobile.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Click.Name = "Click"
Click.Parent = Mobile
Click.AnchorPoint = Vector2.new(0.5, 0.5)
Click.BackgroundColor3 = Color3.new(1, 1, 1)
Click.BackgroundTransparency = 1
Click.Position = UDim2.new(0.5, 0, 0.5, 0)
Click.Size = UDim2.new(1, 0, 1, 0)
Click.Font = Enum.Font.SourceSans
Click.Text = ""
Click.TextColor3 = Color3.new(0, 0, 0)
Click.TextSize = 14

CustomShop.CreateItem({
	Title = "Banana Gun",
	Desc = "#FE",
	Image = "https://cdn.discordapp.com/attachments/1035669085972856973/1096397678625161286/4682374.png",
	Price = "FREE",
	Stack = 1,
})

BananaGun.Parent = game.Players.LocalPlayer.Backpack

function getBananasPlayerOwned()
	local bananas = {}
	for _, instance in ipairs(workspace:GetChildren()) do
		if instance.Name == "BananaPeel" and isnetworkowner(instance) then
			table.insert(bananas,instance)
		end
	end

	return bananas
end

Click.MouseButton1Click:Connect(function()
	local Sound = Instance.new("Sound", game.StarterPlayer) 
	Sound.Volume = 2.5
	Sound.SoundId = "rbxassetid://4700679385"
	Sound.PlayOnRemove = true
	Sound:Destroy()

	local bananas = getBananasPlayerOwned()
	local randomBanana = bananas[math.random(1, #bananas)]

	local velocity = mouse.Hit.LookVector * 0.5 * 200
	local spawnPos = workspace.CurrentCamera.CFrame:ToWorldSpace(CFrame.new(0, 0, -5) * CFrame.lookAt(Vector3.new(0, 0, 0), workspace.CurrentCamera.CFrame.LookVector))

	randomBanana.CFrame = spawnPos
	randomBanana.Velocity = velocity
end)

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

		if game:GetService("UserInputService").TouchEnabled then
			Click.Enabled = true
		end
	end)

	tool.Unequipped:Connect(function()
		Equipped = false
		Char:SetAttribute("Hiding", nil)
		RightArm.Name = "RightUpperArm"
		LeftArm.Name = "LeftUpperArm"

		RightArm.RightShoulder.C1 = RightC1
		LeftArm.LeftShoulder.C1 = LeftC1

				if game:GetService("UserInputService").TouchEnabled then
			Click.Enabled = false
		end
	end)

	tool.Activated:Connect(function()
		local Sound = Instance.new("Sound", game.StarterPlayer) 
		Sound.Volume = 10
		Sound.SoundId = "rbxassetid://4700679385"
		Sound.PlayOnRemove = true
		Sound:Destroy()

		local bananas = getBananasPlayerOwned()
		local randomBanana = bananas[math.random(1, #bananas)]
		
		local velocity = mouse.Hit.LookVector * 0.5 * 200
		local spawnPos = workspace.CurrentCamera.CFrame:ToWorldSpace(CFrame.new(0, 0, -5) * CFrame.lookAt(Vector3.new(0, 0, 0), workspace.CurrentCamera.CFrame.LookVector))

		randomBanana.CFrame = spawnPos
		randomBanana.Velocity = velocity
			
		randomBanana.Touched:Connect(function(part)
		local Model = part:FindFirstAncestorWhichIsA("Model")
		if Model.Name == "JeffTheKiller" then
			Model:FindFirstChild("Humanoid").Health = 0
			task.wait()
			Model:FindFirstChild("Humanoid").Health = 1
			task.wait()
			Model:FindFirstChild("Humanoid").Health = 0	
		end	
	end)
	end)
end

setupHands(BananaGun)
