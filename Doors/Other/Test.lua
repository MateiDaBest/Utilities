repeat wait() until game:IsLoaded()

if not writefile then
	firesignal(game.ReplicatedStorage.EntityInfo.Caption.OnClientEvent, "Executor missing arguement(s) (readfile, writefile, isfile, deletefile) please switch to Fluxus UWP.")
	return
end

local modifier = {}
local linkedObjects = {}
local Data = {}
_G.AddedAmount = 0
_G.ModifersEnabled = 0

local defaultConfig = {
	Tab = {
		Title = "A-90", -- Tab name.
		Image = "http://www.roblox.com/asset/?id=12351005336" -- Tab image.
	},
	Customization = {
		Title = "A-90", -- Modifier title.
		Description = "A-90 is a entity from rooms.", -- Preview description.
		Color = Color3.fromRGB(255, 160, 147), -- Background / text colour.
		Knobs = 50, -- Knob boost amount.
		KnobBonus = true, -- + Knobs.
		KnobPenalty = false, -- - Knobs.
		Connector = false, -- The |- that keeps stuff linked.
		ConnectorEnd = false -- The very last |-.
	}
}

if game.PlaceId == 6839171747 then
	if not isfile("name.txt") or not isfile("knobs.txt") or not isfile("color.txt") then
		return
	end

	local TempMods = game:GetService("Players").LocalPlayer.PlayerGui.MainUI:WaitForChild("Modifiers")
	local MainMods = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics:WaitForChild("Mods")
	local UIS = game:GetService("UserInputService")
	local TabPressed = false
	local Mods = 0

	local decodedData = game:GetService("HttpService"):JSONDecode(readfile("knobs.txt"))
	local decodedData2 = game:GetService("HttpService"):JSONDecode(readfile("name.txt"))
	local decodedData3 = game:GetService("HttpService"):JSONDecode(readfile("color.txt"))

	for _, v in pairs(TempMods:GetDescendants()) do
		if v.Name == "UIListLayout" or v.Name == "Template" or v.Name == "UICorner" or v.Name == "UIPadding" or v.Name == "Desc" or v.Name == "Icon" or v.Name == "BigList" or v.Name == "KnobBonus" or v.Name == "UIGradient" or v.Name == "IconLeft" or v.Name == "NoProgress" or v.Name == "NoRift" or v.Name == "NotFloor" or v.Name == "Tip" or v.Name == "UIGridLayout" then
		else
			v:Destroy()
			return
		end
	end

	spawn(function()
		local Template = TempMods:FindFirstChild("Template"):Clone()
		Template.Text = decodedData2
		Template.Parent = TempMods
		Template.Visible = true
		Template.BackgroundColor3 = Color3.new(decodedData3.R, decodedData3.G, decodedData3.B)
		local Template_2 = MainMods:FindFirstChild("Template"):Clone()
		Template_2.Text = decodedData2
		Template_2.Parent = MainMods
		Template_2.Visible = true
		Template_2.BackgroundColor3 = Color3.new(decodedData3.R, decodedData3.G, decodedData3.B)

		Mods += 1
	end)

	TempMods.Desc.Text = Mods .. " MODIFIER" .. (Mods ~= 1 and "S" or "").. " ACTIVATED"

	game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Visible = true
	game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Text = "MODIFIERS (".. Mods .. ")"
	if decodedData >= 1 then
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = "+ ".. decodedData .. "%"
	elseif decodedData <= 1 then
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = decodedData .. "%"
	else
		game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Statistics.Frame.MODIFIERS.Amount.Text = "+ 0%"
	end

	if decodedData <= -1 then
		TempMods.KnobBonus.Text = decodedData.. "%"
	elseif decodedData >= 1 then
		TempMods.KnobBonus.Text = "+".. decodedData.. "%"
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

modifier.createTab = function(tab)
	if game.PlaceId == 6839171747 then
		return 
	end

	for i, v in next, defaultConfig do
		if tab[i] == nil then
			tab[i] = defaultConfig[i]
		end
	end

	if game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors:FindFirstChild("abc") then
		game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors:FindFirstChild("abc"):Destroy()
		--game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = true
		game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = true
		game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true
		game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = false
	end

	local custom = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel:Clone()
	custom.Visible = false
	custom.Name = "abc"
	custom.Text = tab.Tab.Title
	custom.Background.Image = tab.Tab.Image
	custom.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors

	local custommodifiers = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers:Clone()
	custommodifiers.Visible = false
	custommodifiers.Name = "custommodifiers"
	custommodifiers.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator

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

	game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true

	game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.MouseButton1Click:Connect(function()
		if game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible then
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = false
			custom.Visible = true
			custommodifiers.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = false
		else
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = true
			custom.Visible = false
			custommodifiers.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Visible = false
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
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = false
		else
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavRight.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.NavLeft.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Floors.Hotel.Visible = true
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = true
			custom.Visible = false
			custommodifiers.Visible = false
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Visible = false
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

modifier.createModifier = function(customization)
	for i, v in next, defaultConfig do
		if customization[i] == nil then
			customization[i] = defaultConfig[i]
		end
	end

	if isfile("knobs.txt") then deletefile("knobs.txt") end
	if isfile("name.txt") then deletefile("name.txt") end
	if isfile("color.txt") then deletefile("color.txt") end

	local enabledModifier = false
	local baseName = "Abc"
	local counter = 1

	local function generateUniqueName()
		local newName = baseName .. counter
		while game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild(newName) do
			counter = counter + 1
			newName = baseName .. counter
		end
		return newName
	end


	local modifierCreate = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:WaitForChild("Template"):Clone()
	local Preview = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Preview

	if customization.Customization.Connector == true then
		modifierCreate.Connector.Visible = true
		modifierCreate.ConnectorOut.Visible = true
		modifierCreate.Connector.Position = UDim2.new(-0.063, 0, 1.07, 0)
		modifierCreate.Connector.Size = UDim2.new(0, 4, 1, 8)
	elseif customization.Customization.ConnectorEnd == true then
		modifierCreate.ConnectorOut.Visible = true
	end

	modifierCreate.Visible = true
	
	local function createLinkedGroup()
		local group = {}
		local counter = #linkedObjects + 1
		local selectedInfo

		while game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator:FindFirstChild("Abc" .. counter) do
			table.insert(group, "Abc" .. counter)
			counter = counter + 1
		end

		local function updateConnectorsColor(selectedInfo)
			for _, info in ipairs(linkedObjects) do
				if info and info.Connector and info.ConnectorOut then
					local isSelected = info == selectedInfo
					local transparency = isSelected and 0.7 or 0.9
					local uiStrokeEnabled = isSelected and true or false

					info.BackgroundTransparency = transparency
					info.UIStroke.Enabled = uiStrokeEnabled
				end
			end
		end

		for _, name in ipairs(group) do
			local info = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild(name)

			table.insert(linkedObjects, info)
		end
	end

	modifierCreate.Name = generateUniqueName()
	modifierCreate.Text = customization.Customization.Title
	modifierCreate.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers

	if customization.Customization.KnobBonus == true then
		modifierCreate.Info.KnobPenalty.Visible = false
		modifierCreate.Info.KnobBonus.Text = "+" .. customization.Customization.Knobs .. "%"
		modifierCreate.Info.KnobBonus.Visible = true
	elseif customization.Customization.KnobPenalty == true then
		modifierCreate.Info.KnobPenalty.Visible = true
		modifierCreate.Info.KnobPenalty.Text = customization.Customization.Knobs .. "%"
		modifierCreate.Info.KnobBonus.Visible = false
	end

	modifierCreate.BackgroundColor3 = customization.Customization.Color
	modifierCreate.TextColor3 = customization.Customization.Color

	modifierCreate.MouseEnter:Connect(function()
		-- Preview behavior

		Preview.BackgroundColor3 = customization.Customization.Color
		Preview.Desc.Text = customization.Customization.Description
		Preview.Title.Text = customization.Customization.Title
		Preview.Desc.TextColor3 = customization.Customization.Color
		Preview.Title.TextColor3 = customization.Customization.Color

		if customization.Customization.KnobBonus == true then
			Preview.Info.KnobPenalty.Visible = false
			Preview.Info.KnobBonus.Text = "+" .. customization.Customization.Knobs .. "%"
			Preview.Info.KnobBonus.Visible = true
		elseif customization.Customization.KnobPenalty == true then
			Preview.Info.KnobPenalty.Visible = true
			Preview.Info.KnobPenalty.Text = customization.Customization.Knobs .. "%"
			Preview.Info.KnobBonus.Visible = false
		end

		Preview.Visible = true
		Preview.Info.NoProgress.Visible = false
		Preview.Info.NoRift.Visible = false
	end)

	modifierCreate.MouseButton1Click:Connect(function()

		if not enabledModifier then
			enabledModifier = true
			_G.AddedAmount += tonumber(customization.Customization.Knobs)
			_G.ModifersEnabled += 1

			--modifierCreate.ConnectorOut.BackgroundColor3 = Color3.fromRGB(255, 160, 147)
			--modifierCreate.Connector.BackgroundColor3 = Color3.fromRGB(255, 160, 147)

			--modifierCreate.BackgroundTransparency = 0.7
			--modifierCreate.UIStroke.Enabled = true
			
			createLinkedGroup()
			print("Ran")
		else
			enabledModifier = false

			_G.AddedAmount -= tonumber(customization.Customization.Knobs)
			_G.ModifersEnabled -= 1

			--modifierCreate.ConnectorOut.BackgroundColor3 = Color3.fromRGB(103, 73, 63)
			--modifierCreate.Connector.BackgroundColor3 = Color3.fromRGB(103, 73, 63)

			--modifierCreate.BackgroundTransparency = 0.9
			--modifierCreate.UIStroke.Enabled = false
		end
	end)

	local Confirm = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator:FindFirstChild("customConfirm")

	if not Confirm then
		Confirm = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Confirm:Clone()
		Confirm.Name = "customConfirm"
		Confirm.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator
		Confirm.Visible = false
	end

	Confirm.MouseButton1Click:Connect(function()
		-- Confirming changes

		game.Players.LocalPlayer.PlayerGui.MainUI.Modifiers.Visible = true
		local ModifiersMain = game.Players.LocalPlayer.PlayerGui.MainUI.Modifiers
		local MaxPlayers = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Settings.MaxPlayers.Toggle.Text
		local FriendsOnly = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Settings.FriendsOnly.Toggle.BackgroundTransparency == 0.9

		local A_1 = {
			["Mods"] = {},
			["FriendsOnly"] = FriendsOnly,
			["MaxPlayers"] = MaxPlayers
		}

		local Event = game:GetService("ReplicatedStorage").EntityInfo.CreateElevator
		Event:FireServer(A_1)

		ModifiersMain.Desc.Visible = _G.ModifersEnabled > 0
		ModifiersMain.Visible = true
		ModifiersMain.KnobBonus.Text = _G.AddedAmount .. "%"
		ModifiersMain.Desc.Text = _G.ModifersEnabled .. " MODIFIER" .. (_G.ModifersEnabled ~= 1 and "S" or "") .. " ACTIVATED"

		if enabledModifier then
			local Template = ModifiersMain.Template:Clone()
			Template.Name = "abc"
			Template.Visible = true
			Template.Parent = ModifiersMain
			Template.Text = customization.Customization.Title
			Template.BackgroundColor3 = customization.Customization.Color
			table.insert(Data, customization.Customization.Title)
		end

		writefile("knobs.txt", game:GetService("HttpService"):JSONEncode(_G.AddedAmount))
		writefile("name.txt", game:GetService("HttpService"):JSONEncode(customization.Customization.Title))

		local colorTable = {
			R = customization.Customization.Color.R,
			G = customization.Customization.Color.G,
			B = customization.Customization.Color.B
		}

		writefile("color.txt", game:GetService("HttpService"):JSONEncode(colorTable))
	end)

	spawn(function()
		while wait() do
			local knobBonusText = _G.AddedAmount ~= 0 and (_G.AddedAmount > 0 and "+" or "") .. _G.AddedAmount .. "%" or "+0%"
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.KnobBonus.Text = knobBonusText

			if _G.ModifersEnabled == 0 then
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.Desc.Visible = false
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.ModIcon.Visible = false
			else
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.Desc.Visible = true
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.Desc.Text = _G.ModifersEnabled .. " MODIFIER" .. (_G.ModifersEnabled ~= 1 and "S" or "")
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.ModIcon.Visible = true
			end
		end
	end)
end

return modifier -- a
