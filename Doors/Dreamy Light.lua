-- Dreamy Light

local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()

local UIS = game:GetService("UserInputService")

local DeathHint = game:GetService("ReplicatedStorage").EntityInfo.DeathHint
local Yellow = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainUI"):FindFirstChild("Initiator"):FindFirstChild("Main_Game"):FindFirstChild("Health"):FindFirstChild("Music"):FindFirstChild("Yellow")
local End = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainUI"):FindFirstChild("Initiator"):FindFirstChild("Main_Game"):FindFirstChild("Health"):FindFirstChild("Music"):FindFirstChild("Yellow"):FindFirstChild("End")
local LightContainer = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainUI"):FindFirstChild("Death")
local DreamyLightSong = "https://cdn.discordapp.com/attachments/1035669085972856973/1088867367314014349/Dreamy_Light.mp3"
local DreamyLightEndSong = "https://cdn.discordapp.com/attachments/1035669085972856973/1088867903291523082/Dreamy_Light_End.mp3"

_G.Dialog = {
	
}

while wait() do
	LightContainer.Static.BackgroundColor3 = Color3.new(0.635294, 1, 0.494118)
end

LightContainer.Static.BackgroundColor3 = Color3.new(0.635294, 1, 0.494118)
LightContainer.Static.ImageColor3 = Color3.new(0.635294, 1, 0.494118)
LightContainer.HelpfulDialogue.TextColor3 = Color3.new(0.635294, 1, 0.494118)

Yellow.SoundId = LoadCustomAsset(DreamyLightSong)
End.SoundId = LoadCustomAsset(DreamyLightEndSong)

UIS.InputBegan:Connect(function(Key, Chatting)
	if Chatting then return end
	if Key.KeyCode == Enum.KeyCode.Q then
		game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid").Health = 0
		game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = _G.DeathCause
		firesignal(DeathHint.OnClientEvent, _G.Dialog, "Yellow")
	end
end)
