repeat wait() until game:IsLoaded()

if not writefile then
	firesignal(game.ReplicatedStorage.EntityInfo.Caption.OnClientEvent, "Executor missing arguement(s) (readfile, writefile, isfile, deletefile) please switch to Fluxus or Krnl.")
	return
end

if _G.alreadyExecuted then
	firesignal(game.ReplicatedStorage.EntityInfo.Caption.OnClientEvent, "Executed twice, bugs may accure.")
end

_G.alreadyExecuted = true

local modifier = {}
local linkedObjects = {}
local Data = {}
local AddedAmount = 0
local ModifiersEnabled = 0

local KnobsFromEachModifier = {}

local function createLinkedGroup(CE, CEE, color, knob, count)
	local connectorsEnabled = CE
	local connectorsEndEnabled = CEE

	local currentLinkedGroup = {}
	local counter = #linkedObjects + 1

	while game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild("Abc" .. counter) do
		if game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild("Abc" .. counter).Connector.Visible or game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild("Abc" .. counter).ConnectorOut.Visible then 
			table.insert(currentLinkedGroup, "Abc" .. counter)
		end
		counter += 1
	end

	local selectedInfo = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild("Abc1")

	local function updateConnectorsColor(selectedButton)
		local connectorsColor = selectedButton and color or Color3.fromRGB(103, 73, 63)
		local selectedTransparency = selectedButton and 0 or 0.8
		local unselectedTransparency = selectedButton and 0.8 or 0

		for _, name in ipairs(currentLinkedGroup) do
			local info = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild(name)

			if info then
				if info == selectedButton then
					if not KnobsFromEachModifier[selectedButton] then KnobsFromEachModifier[selectedButton] = tonumber(knob) end

					AddedAmount += KnobsFromEachModifier[selectedButton]
					ModifiersEnabled += 1
					_G["enabled".. count] = false
					info.BackgroundTransparency = 0.7
					info.UIStroke.Enabled = true
					info.UIStroke.Color = color
					info.TextTransparency = 0
					for i, v in pairs(currentLinkedGroup) do
						if v ~= selectedButton then
							local button = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild(v)
							if button and KnobsFromEachModifier[button] then
								AddedAmount -= KnobsFromEachModifier[button]
							end
						end
					end
				else
					if not KnobsFromEachModifier[selectedButton] then KnobsFromEachModifier[selectedButton] = tonumber(knob) end
					_G["enabled".. count] = true
					AddedAmount -= KnobsFromEachModifier[selectedButton]
					ModifiersEnabled -= 1
					info.BackgroundTransparency = 0.9
					info.UIStroke.Enabled = false
					info.TextTransparency = 0.8
				end

				info.Connector.BackgroundColor3 = connectorsColor
				info.ConnectorOut.BackgroundColor3 = connectorsColor
				info.TextTransparency = info == selectedButton and selectedTransparency or unselectedTransparency
			end
		end
	end

	for _, name in ipairs(currentLinkedGroup) do
		local info = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers:FindFirstChild(name)
		if info then
			table.insert(linkedObjects, info)
			info.MouseButton1Click:Connect(function()
				if selectedInfo == info then
					selectedInfo = nil
					updateConnectorsColor(selectedInfo)
				else
					selectedInfo = info
					updateConnectorsColor(selectedInfo)
				end
			end)
		end
	end

	updateConnectorsColor(selectedInfo)
end

local defaultConfig = {
	Tab = {
		Title = "A-90", -- Tab name.
		Image = "http://www.roblox.com/asset/?id=12351005336" -- Tab image.
	},
	Customization = {
		Title = "A-90", -- Modifier name.
		Description = "A-90 is a entity from rooms.", -- Preview description.
		Color = Color3.fromRGB(255, 160, 147), -- Background / text colour.
		Knobs = 50, -- Knob boost amount.
		NoProgress = false, -- No progress.
		NoRift = false, -- No rift.
		Connector = false, -- The |- that keeps stuff linked.
		ConnectorEnd = false -- The very last |-.
	}
}

modifier.createModifierLogic = function(selected, url)
	local pass = false
	if not isfile("name.txt") and game.PlaceId == 6839171747 then
		pass = true
	end

	if pass then
		local decodedData = game:GetService("HttpService"):JSONDecode(readfile("name.txt"))

		for _, v in ipairs(decodedData) do
			if v == selected then
				loadstring(game:HttpGet(url))()
				return
			end
		end
	end
end

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
	local decodedData4 = game:GetService("HttpService"):JSONDecode(readfile("np.txt"))
	local decodedData5 = game:GetService("HttpService"):JSONDecode(readfile("nr.txt"))

	for _, v in pairs(TempMods:GetDescendants()) do
		if v.Name == "UIListLayout" or v.Name == "Template" or v.Name == "UICorner" or v.Name == "UIPadding" or v.Name == "Desc" or v.Name == "Icon" or v.Name == "BigList" or v.Name == "KnobBonus" or v.Name == "UIGradient" or v.Name == "IconLeft" or v.Name == "NoProgress" or v.Name == "NoRift" or v.Name == "NotFloor" or v.Name == "Tip" or v.Name == "UIGridLayout" then
		else
			v:Destroy()
			return
		end
	end

	for _, v in ipairs(decodedData2) do
		Mods += 1

		local Template = TempMods:FindFirstChild("Template"):Clone()
		Template.Text = v
		Template.Parent = TempMods
		Template.Visible = true
		Template.BackgroundColor3 = Color3.new(decodedData3.R, decodedData3.G, decodedData3.B)

		local Template_2 = MainMods:FindFirstChild("Template"):Clone()
		Template_2.Text = v
		Template_2.Parent = MainMods
		Template_2.Visible = true
		Template_2.BackgroundColor3 = Color3.new(decodedData3.R, decodedData3.G, decodedData3.B)
	end

	game:GetService("Players").LocalPlayer.PlayerGui.PermUI.Topbar.Modifiers.Visible = true
	game:GetService("Players").LocalPlayer.PlayerGui.PermUI.Topbar.Modifiers.Text = Mods

	TempMods.Desc.Text = Mods .. " MODIFIER" .. (Mods ~= 1 and "S" or "").. " ACTIVATED"

	if decodedData4 == true then
		TempMods.NoProgress.Visible = true
	else
		TempMods.NoProgress.Visible = false
	end

	if decodedData5 == true then
		TempMods.NoRift.Visible = true
	else
		TempMods.NoRift.Visible = false
	end

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
		game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers.Visible = true
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
		if isfile("knobs.txt") then deletefile("knobs.txt") end
		if isfile("name.txt") then deletefile("name.txt") end
		if isfile("color.txt") then deletefile("color.txt") end
		if isfile("nr.txt") then deletefile("nr.txt") end
		if isfile("np.txt") then deletefile("np.txt") end	

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

modifier.createModifier = function(lO, customization)
	if game.PlaceId == 6839171747 then
		return 
	end

	for i, v in next, defaultConfig do
		if customization[i] == nil then
			customization[i] = defaultConfig[i]
		end
	end

	if isfile("knobs.txt") then deletefile("knobs.txt") end
	if isfile("name.txt") then deletefile("name.txt") end
	if isfile("color.txt") then deletefile("color.txt") end
	if isfile("nr.txt") then deletefile("nr.txt") end
	if isfile("np.txt") then deletefile("np.txt") end	

	local baseName = "Abc"
	local counter = 1

	_G["enabled".. counter] = false

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
		modifierCreate.Connector.Position = UDim2.new(-0.063, 0, 1.06, 0)
		modifierCreate.Connector.Size = UDim2.new(0, 4, 1, 8)
	elseif customization.Customization.ConnectorEnd == true then
		modifierCreate.ConnectorOut.Visible = true
	end

	modifierCreate.Visible = true
	modifierCreate.Name = generateUniqueName()
	modifierCreate.Text = customization.Customization.Title
	modifierCreate.LayoutOrder = lO or 1
	modifierCreate.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers

	if customization.Customization.NoProgress == true then
		modifierCreate.Info.NoProgress.Visible = true
	else
		modifierCreate.Info.NoProgress.Visible = false
	end

	if customization.Customization.NoRift == true then
		modifierCreate.Info.NoRift.Visible = true
	else
		modifierCreate.Info.NoRift.Visible = false
	end

	if tonumber(customization.Customization.Knobs) >= 1 then
		modifierCreate.Info.KnobPenalty.Visible = false
		modifierCreate.Info.KnobBonus.Text = "+" .. customization.Customization.Knobs .. "%"
		modifierCreate.Info.KnobBonus.Visible = true
		modifierCreate.Info.KnobBonus.Name = tonumber(customization.Customization.Knobs)
	elseif tonumber(customization.Customization.Knobs) <= -1 then
		modifierCreate.Info.KnobPenalty.Visible = true
		modifierCreate.Info.KnobPenalty.Text = customization.Customization.Knobs .. "%"
		modifierCreate.Info.KnobBonus.Visible = false
		modifierCreate.Info.KnobPenalty.Name = tonumber(customization.Customization.Knobs)
	end

	modifierCreate.BackgroundColor3 = customization.Customization.Color
	modifierCreate.TextColor3 = customization.Customization.Color

	modifierCreate.MouseEnter:Connect(function()
		Preview.BackgroundColor3 = customization.Customization.Color
		Preview.Desc.Text = customization.Customization.Description
		Preview.Title.Text = customization.Customization.Title
		Preview.Desc.TextColor3 = customization.Customization.Color
		Preview.Title.TextColor3 = customization.Customization.Color

		if customization.Customization.NoProgress == true then
			Preview.Info.NoProgress.Visible = true
		else
			Preview.Info.NoProgress.Visible = false
		end

		if customization.Customization.NoRift == true then
			Preview.Info.NoRift.Visible = true
		else
			Preview.Info.NoRift.Visible = false
		end

		if tonumber(customization.Customization.Knobs) >= 1 then
			Preview.Info.KnobPenalty.Visible = false
			Preview.Info.KnobBonus.Text = "+" .. customization.Customization.Knobs .. "%"
			Preview.Info.KnobBonus.Visible = true
		elseif tonumber(customization.Customization.Knobs) <= -1 then
			Preview.Info.KnobPenalty.Visible = true
			Preview.Info.KnobPenalty.Text = customization.Customization.Knobs .. "%"
			Preview.Info.KnobBonus.Visible = false
		end

		Preview.Visible = true
	end)

	modifierCreate.MouseButton1Click:Connect(function()
		if not _G["enabled".. counter] then
			ModifiersEnabled += 1
			
			if customization.Customization.Connector == false then
				_G["enabled".. counter] = true
				AddedAmount += tonumber(customization.Customization.Knobs)
			elseif customization.Customization.ConnectorOut == false then
				_G["enabled".. counter] = true
				AddedAmount += tonumber(customization.Customization.Knobs)
			else
				createLinkedGroup(customization.Customization.Connector, customization.Customization.ConnectorEnd, customization.Customization.Color, customization.Customization.Knobs, counter)
			end
		else
			ModifiersEnabled -= 1
			AddedAmount -= tonumber(customization.Customization.Knobs)
			if customization.Customization.Connector == false then
				_G["enabled".. counter] = false
			elseif customization.Customization.ConnectorOut == false then
				_G["enabled".. counter] = false
			end
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

		ModifiersMain.Desc.Visible = ModifiersEnabled > 0
		ModifiersMain.Visible = true
		ModifiersMain.KnobBonus.Text = AddedAmount .. "%"
		ModifiersMain.Desc.Text = ModifiersEnabled .. " MODIFIER" .. (ModifiersEnabled ~= 1 and "S" or "") .. " ACTIVATED"

		if customization.Customization.NoProgress == true then
			writefile("np.txt", game:GetService("HttpService"):JSONEncode(true))
			ModifiersMain.NoProgress.Visible = true
		else
			ModifiersMain.NoProgress.Visible = false
		end

		if customization.Customization.NoRift == true then
			writefile("nr.txt", game:GetService("HttpService"):JSONEncode(true))
			ModifiersMain.NoRift.Visible = true
		else
			ModifiersMain.NoRift.Visible = false
		end

		if _G["enabled".. counter] then
			local Template = ModifiersMain.Template:Clone()
			Template.Name = "abc"
			Template.Visible = true
			Template.Parent = ModifiersMain
			Template.Text = customization.Customization.Title
			Template.BackgroundColor3 = customization.Customization.Color
			table.insert(Data, customization.Customization.Title)
		end

		writefile("knobs.txt", game:GetService("HttpService"):JSONEncode(AddedAmount))
		writefile("name.txt", game:GetService("HttpService"):JSONEncode(Data))

		local colorTable = {
			R = customization.Customization.Color.R,
			G = customization.Customization.Color.G,
			B = customization.Customization.Color.B
		}

		writefile("color.txt", game:GetService("HttpService"):JSONEncode(colorTable))
	end)

	spawn(function()
		while wait() do
			local knobBonusText = AddedAmount ~= 0 and (AddedAmount > 0 and "+" or "") .. AddedAmount .. "%" or "+0%"
			game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.KnobBonus.Text = knobBonusText

			if customization.Customization.NoProgress == true and ModifiersEnabled ~= 0 then
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.NoProgress.Visible = true
			else
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.NoProgress.Visible = false
			end

			if customization.Customization.NoRift == true then
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.NoRift.Visible = true
			else
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.NoRift.Visible = false
			end

			if ModifiersEnabled == 0 then
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.Desc.Visible = false
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.ModIcon.Visible = false
			else
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.Desc.Visible = true
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.Desc.Text = ModifiersEnabled .. " MODIFIER" .. (ModifiersEnabled ~= 1 and "S" or "")
				game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.customConfirm.Info.ModIcon.Visible = true
			end
		end
	end)
end

modifier.createSeperator = function(lO, color)
	if game.PlaceId == 6839171747 then
		return 
	end

	local Seperator = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.Modifiers:WaitForChild("Separator"):Clone()
	Seperator.Parent = game.Players.LocalPlayer.PlayerGui.MainUI.LobbyFrame.CreateElevator.custommodifiers
	Seperator.Visible = true
	Seperator.BackgroundColor3 = color or Color3.fromRGB(103, 73, 63)
	Seperator.LayoutOrder = lO or 2
end

return modifier
