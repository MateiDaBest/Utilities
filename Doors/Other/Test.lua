repeat wait() until game:IsLoaded()

if not writefile then
	firesignal(game.ReplicatedStorage.EntityInfo.Caption.OnClientEvent, "Executor missing arguement(s) (readfile, writefile, isfile, deletefile) please switch to Fluxus UWP.")
	return
end

local modifiers = {}
local Data = {}
local AddedAmount = 0
local ModifersEnabled = 0

local Floor = game:GetService("ReplicatedStorage").GameData.Floor
if Floor.Value == "Hotel" and game.PlaceId == 6839171747 then
	if not isfile("name.txt") then
		return
	end

	local TempMods = game:GetService("Players").LocalPlayer.PlayerGui.MainUI:WaitForChild("Modifiers")
	local MainMods = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics:WaitForChild("Mods")
	local UIS = game:GetService("UserInputService")
	local TabPressed = false
	local Mods = 0

	local jsonData2 = readfile("knobs.txt")
	local decodedData2 = game:GetService("HttpService"):JSONDecode(jsonData2)

	local jsonData3 = readfile("name.txt")
	local decodedData3 = game:GetService("HttpService"):JSONDecode(jsonData3)

	local jsonData4 = readfile("color.txt")
	local decodedData4 = game:GetService("HttpService"):JSONDecode(jsonData4)

	for _, v in pairs(TempMods:GetDescendants()) do
		if v.Name == "UIListLayout" or v.Name == "Template" or v.Name == "UICorner" or v.Name == "UIPadding" or v.Name == "Desc" or v.Name == "Icon" or v.Name == "BigList" or v.Name == "KnobBonus" or v.Name == "UIGradient" or v.Name == "IconLeft" or v.Name == "NoProgress" or v.Name == "NoRift" or v.Name == "NotFloor" or v.Name == "Tip" or v.Name == "UIGridLayout" then
		else
			v:Destroy()
			return
		end
	end

	spawn(function()
		local Template = TempMods:FindFirstChild("Template"):Clone()
		Template.Text = jsonData3
		Template.Parent = TempMods
		Template.Visible = true
		Template.BackgroundColor3 = jsonData4
		local Template_2 = MainMods:FindFirstChild("Template"):Clone()
		Template_2.Text = jsonData3
		Template_2.Parent = MainMods
		Template_2.Visible = true
		Template_2.BackgroundColor3 = jsonData4
		Mods += 1
	end)

	TempMods.Desc.Text = Mods .. " MODIFIER" .. (Mods ~= 1 and "S" or "").. " ACTIVATED"
	
	game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Visible = true
	game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Text = "MODIFIERS (".. Mods .. ")"
	if decodedData2 >= 1 then
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = "+ ".. decodedData2 .. "%"
	elseif decodedData2 <= 1 then
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = decodedData2 .. "%"
	else
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = "+ 0%"
	end

	if decodedData2 <= -1 then
		TempMods.KnobBonus.Text = decodedData2.. "%"
	elseif decodedData2 >= 1 then
		TempMods.KnobBonus.Text = "+".. decodedData2.. "%"
	end

	spawn(function()
		TempMods.Visible = true
		TempMods.Tip.Text = "To check this list, press TAB"
		TempMods.Tip.Visible = true
		wait(15)
		TempMods.Visible = false
		TempMods.Tip.Visible = false
	end)

	UIS.InputBegan:Connect(function(key, gP)
		if key.KeyCode == Enum.KeyCode.Tab and not gP then
			TabPressed = not TabPressed
			TempMods.Visible = TabPressed
			TempMods.Tip.Visible = false
		end
	end)

	return
elseif Floor.Value == "Rooms" then
	if not isfile("name.txt") then
		return
	end

	workspace.CurrentRooms.ChildAdded:Connect(function(C)
		for _, v in pairs(C:GetDescendants()) do
			if v.Name == "RedForcefield" then
				v:Destroy()
			end
		end
	end)

	local TempMods = game:GetService("Players").LocalPlayer.PlayerGui.MainUI:WaitForChild("Modifiers")
	local MainMods = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics:WaitForChild("Mods")
	local UIS = game:GetService("UserInputService")
	local TabPressed = false
	local Mods = 0
	
	local jsonData2 = readfile("knobs.txt")
	local decodedData2 = game:GetService("HttpService"):JSONDecode(jsonData2)
	
	local jsonData3 = readfile("name.txt")
	local decodedData3 = game:GetService("HttpService"):JSONDecode(jsonData3)
	
	local jsonData4 = readfile("color.txt")
	local decodedData4 = game:GetService("HttpService"):JSONDecode(jsonData4)

	for _, v in pairs(TempMods:GetDescendants()) do
		if v.Name == "UIListLayout" or v.Name == "Template" or v.Name == "UICorner" or v.Name == "UIPadding" or v.Name == "Desc" or v.Name == "Icon" or v.Name == "BigList" or v.Name == "KnobBonus" or v.Name == "UIGradient" or v.Name == "IconLeft" or v.Name == "NoProgress" or v.Name == "NoRift" or v.Name == "NotFloor" or v.Name == "Tip" or v.Name == "UIGridLayout" then
		else
			v:Destroy()
			return
		end
	end
	
	spawn(function()
		local Template = TempMods:FindFirstChild("Template"):Clone()
		Template.Text = decodedData3
		Template.Parent = TempMods
		Template.Visible = true
		Template.BackgroundColor3 = decodedData4
		local Template_2 = MainMods:FindFirstChild("Template"):Clone()
		Template_2.Text = decodedData3
		Template_2.Parent = MainMods
		Template_2.Visible = true
		Template_2.BackgroundColor3 = decodedData4
		Mods += 1
	end)


	spawn(function()
		task.defer(modifiers.modifierLogic)
	end)
	print(Mods)
	TempMods.Desc.Text = Mods .. " MODIFIER" .. (Mods ~= 1 and "S" or "").. " ACTIVATED"
	game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Visible = true
	game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Text = "MODIFIERS (".. Mods .. ")" 
	if decodedData2 >= 1 then
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = "+ ".. decodedData2 .. "%"
	elseif decodedData2 <= 1 then
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = decodedData2 .. "%"
	else
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = "+ 0%"
	end

	if decodedData2 <= -1 then
		TempMods.KnobBonus.Text = decodedData2.. "%"
	elseif decodedData2 >= 1 then
		TempMods.KnobBonus.Text = "+".. decodedData2.. "%"
	end

	spawn(function()
		TempMods.Visible = true
		TempMods.Tip.Text = "To check this list, press TAB"
		TempMods.Tip.Visible = true
		wait(15)
		TempMods.Visible = false
		TempMods.Tip.Visible = false
	end)

	UIS.InputBegan:Connect(function(key, gP)
		if key.KeyCode == Enum.KeyCode.Tab and not gP then
			TabPressed = not TabPressed
			TempMods.Visible = TabPressed
			TempMods.Tip.Visible = false
		end
	end)
	return
end

local defaultConfig = {
	CustomTab = {
		Image = "http://www.roblox.com/asset/?id=12351005336",
		Text = "A-90"
	}
}

local defaultConfig2 = {
	ButtonCustomization = {
		Color = Color3.fromRGB(255, 160, 147),
		Name = "A-90",
		Description = "A-90 is a entity from rooms.",
		Knobs = "50",
		KnobBonus = true, -- +50%
		KnobPenalty = false, -- -50%
		Linked = false
	}
}

modifiers.createTab = function(config)
	for i, v in next, defaultConfig do
		if config[i] == nil then
			config[i] = defaultConfig[i]
		end
	end

	local custom = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel:Clone()
	custom.Visible = false
	custom.Name = config.CustomTab.Name
	custom.Text = config.CustomTab.Name
	custom.Background.Image = config.CustomTab.Image
	custom.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors

	local custommodifiers = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers:Clone()
	custommodifiers.Visible = false
	custommodifiers.Name = "custommodifiers"
	custommodifiers.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator
	
	game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true

	game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.MouseButton1Click:Connect(function()
		if game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible then
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = false
			custom.Visible = true
			custommodifiers.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.RoomsConfirm.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = false
		else
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = true
			custom.Visible = false
			custommodifiers.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.RoomsConfirm.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true
		end
	end)

	game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.MouseButton1Click:Connect(function()
		if game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible then
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = false
			custom.Visible = true
			custommodifiers.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.RoomsConfirm.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = false
		else
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = true
			custom.Visible = false
			custommodifiers.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.RoomsConfirm.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true
		end
	end)

	for _, v in pairs(custommodifiers:GetDescendants()) do
		if v:IsA("TextButton") and v.Name ~= "Template" then
			v:Destroy()
		end
	end

	for _, v in pairs(custommodifiers:GetDescendants()) do
		if v:IsA("Frame") and v.Name == "Separator" then
			v:Destroy()
		end
	end
end

modifiers.createModifier = function(config)
	print("Detected")
	for i, v in next, defaultConfig2 do
		if config[i] == nil then
			config[i] = defaultConfig2[i]
		end
	end
	
	local enabledModifier = false
	
	if isfile("knobs.txt") then
		deletefile("knobs.txt")
	end
	
	if isfile("name.txt") then
		deletefile("name.txt")
	end
	
	if isfile("color.txt") then
		deletefile("color.txt")
	end
	
	local Confirm = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm:Clone()
	Confirm.Name = "RoomsConfirm"
	Confirm.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator
	Confirm.Visible = false
	Confirm.MouseButton1Click:Connect(function()
		game.Players.LocalPlayer.PlayerGui.MainUI.Modifiers.Visible = true
		local ModifiersMain = game.Players.LocalPlayer.PlayerGui.MainUI.Modifiers
		local MaxPlayers = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Settings.MaxPlayers.Toggle.Text
		local FriendsOnly

		if game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Settings.FriendsOnly.Toggle.BackgroundTransparency == 0.9 then
			FriendsOnly = false
		else
			FriendsOnly = true
		end

		local A_1 = 
			{
				["Mods"] = {}, 
				["FriendsOnly"] = FriendsOnly, 
				["MaxPlayers"] = MaxPlayers
			}

		local Event = game:GetService("ReplicatedStorage").EntityInfo.CreateElevator
		Event:FireServer(A_1)

		if ModifersEnabled == 0 then
			ModifiersMain.Desc.Visible = false
		else
			ModifiersMain.Desc.Visible = true
		end

		ModifiersMain.Visible = true
		ModifiersMain.KnobBonus.Text = AddedAmount.. "%"
		ModifiersMain.Desc.Text = ModifersEnabled .. " MODIFIER" .. (ModifersEnabled ~= 1 and "S" or "").. " ACTIVATED"

		if enabledModifier then
			local Template = ModifiersMain.Template:Clone()
			Template.Name = "abc"
			Template.Visible = true
			Template.Parent = ModifiersMain
			Template.Text = config.ButtonCustomization.Name
			Template.BackgroundColor3 = config.ButtonCustomization.Color
			table.insert(Data, config.ButtonCustomization.Name)
		end

		writefile("knobs.txt", tostring(game:GetService("HttpService"):JSONEncode(AddedAmount)))
		writefile("name.txt", tostring(game:GetService("HttpService"):JSONEncode(config.ButtonCustomization.Name)))
		writefile("color.txt", tostring(game:GetService("HttpService"):JSONEncode(config.ButtonCustomization.Color)))
	end)
	
	local Exit = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.LobbyFrame.ExitElevator:Clone()
	game:GetService("Players").LocalPlayer.PlayerGui.MainUI.LobbyFrame.ExitElevator:Destroy()
	Exit.Parent = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.LobbyFrame
	Exit.MouseButton1Click:Connect(function()
		
		if isfile("knobs.txt") then
			deletefile("knobs.txt")
		end
		
		if isfile("name.txt") then
			deletefile("name.txt")
		end

		if isfile("color.txt") then
			deletefile("color.txt")
		end
		game:GetService("ReplicatedStorage").EntityInfo.ElevatorExit:FireServer()
		game.Players.LocalPlayer.PlayerGui.MainUI.Modifiers.Visible = false
		for _, v in pairs(game.Players.LocalPlayer.PlayerGui.MainUI.Modifiers:GetDescendants()) do
			if v.Name == "abc" then
				v:Destroy()
			end
		end
	end)
	
	local modifierCreate = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:WaitForChild("Template"):Clone()
	local Preview = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Preview
	
	modifierCreate.Visible = true
	modifierCreate.Text = config.ButtonCustomization.Name
	modifierCreate.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers
	if config.ButtonCustomization.KnobBonus == true then
		modifierCreate.Info.KnobPenalty.Visible = false
		modifierCreate.Info.KnobBonus.Text = "+".. config.ButtonCustomization.Knobs.. "%"
		modifierCreate.Info.KnobBonus.Visible = true
	elseif config.ButtonCustomization.KnobPenalty == true then
		modifierCreate.Info.KnobPenalty.Visible = true
		modifierCreate.Info.KnobPenalty.Text = config.ButtonCustomization.Knobs.. "%"
		modifierCreate.Info.KnobBonus.Visible = false
	end
	modifierCreate.BackgroundColor3 = config.ButtonCustomization.Color
	modifierCreate.TextColor3 = config.ButtonCustomization.Color
	modifierCreate.MouseEnter:Connect(function()
		Preview.BackgroundColor3 = config.ButtonCustomization.Color
		Preview.Desc.Text = config.ButtonCustomization.Description
		Preview.Title.Text = config.ButtonCustomization.Name
		Preview.Desc.TextColor3 = config.ButtonCustomization.Color
		Preview.Title.TextColor3 = config.ButtonCustomization.Color
		if config.ButtonCustomization.KnobBonus == true then
			Preview.Info.KnobPenalty.Visible = false
			Preview.Info.KnobBonus.Text = "+".. config.ButtonCustomization.Knobs.. "%"
			Preview.Info.KnobBonus.Visible = true
		elseif config.ButtonCustomization.KnobPenalty == true then
			Preview.Info.KnobPenalty.Visible = true
			Preview.Info.KnobPenalty.Text = config.ButtonCustomization.Knobs.. "%"
			Preview.Info.KnobBonus.Visible = false
		end

		Preview.Visible = true
		Preview.Info.NoProgress.Visible = false
		Preview.Info.NoRift.Visible = false
	end)

	modifierCreate.MouseButton1Click:Connect(function()
		if not enabledModifier then
			enabledModifier = true

			AddedAmount += tonumber(config.ButtonCustomization.Knobs)
			ModifersEnabled += 1

			modifierCreate.ConnectorOut.BackgroundColor3 = Color3.fromRGB(255, 160, 147)
			modifierCreate.Connector.BackgroundColor3 = Color3.fromRGB(255, 160, 147)

			modifierCreate.BackgroundTransparency = 0.7
			modifierCreate.UIStroke.Enabled = true
		else
			enabledModifier = false

			AddedAmount -= tonumber(config.ButtonCustomization.Knobs)
			ModifersEnabled -= 1

			modifierCreate.ConnectorOut.BackgroundColor3 = Color3.fromRGB(103, 73, 63)
			modifierCreate.Connector.BackgroundColor3 = Color3.fromRGB(103, 73, 63)

			modifierCreate.BackgroundTransparency = 0.9
			modifierCreate.UIStroke.Enabled = false
		end
	end)
	
	spawn(function()
		while wait() do
			if AddedAmount <= -1 then
				Confirm.Info.KnobBonus.Text = AddedAmount.. "%"
			elseif AddedAmount >= 1 then
				Confirm.Info.KnobBonus.Text = "+".. AddedAmount.. "%"
			elseif AddedAmount == 0 then
				Confirm.Info.KnobBonus.Text = "+0%"
			end

			if ModifersEnabled == 0 then
				Confirm.Info.Desc.Visible = false
				Confirm.Info.ModIcon.Visible = false
			else
				Confirm.Info.Desc.Visible = true
				Confirm.Info.Desc.Text = ModifersEnabled .. " MODIFIER" .. (ModifersEnabled ~= 1 and "S" or "")
				Confirm.Info.ModIcon.Visible = true
			end
		end
	end)
end

return modifiers
