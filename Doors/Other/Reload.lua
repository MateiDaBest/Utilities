local v19 = { 
	cef = game:GetService("Players").LocalPlayer.PlayerGui.MainUI:WaitForChild("LobbyFrame"):WaitForChild("CreateElevator"), 
};

local l_Floors_0 = v19.cef.Floors;

local v58 = {
	penalties = {}, 
	mods = {}
};

local v59 = 1;
local v60 = false;
local v61 = false;
local v63 = "Hotel";
local v64 = 1;
local v65 = {
	"Hotel"
};

local l_Achievements_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));

local l_AccessibleFloors_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("AccessibleFloors"));
local l_Modifiers_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modifiers"));
local l_ReplicaDataModule_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
local l_GetPlatform_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local v2 = require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Lobby)

local v52, v53 = l_GetPlatform_0();

resetMods = function()
	if l_ReplicaDataModule_0.data and l_ReplicaDataModule_0.data.Achievements and not v60 then
		if table.find(l_ReplicaDataModule_0.data.Achievements, "EscapeHotel") then
			v60 = true;
			print("Modifiers should be enabled! [METHOD 1]");
		end;
		for _, v67 in pairs(l_ReplicaDataModule_0.data.Achievements) do
			if v67 == "EscapeHotel" then
				print("Modifiers should be enabled! [METHOD 2]");
				v60 = true;
			end;
		end;
	end;
	v65 = {};
	v64 = 0;
	if l_ReplicaDataModule_0.data and l_ReplicaDataModule_0.data.Achievements then
		for v68, v69 in pairs(l_AccessibleFloors_0) do
			local v70 = true;
			if v69.Requires then
				local l_NeedAll_0 = v69.Requires.NeedAll;
				v70 = false;
				if l_NeedAll_0 == true then
					v70 = true;
				end;
				for _, v73 in pairs(v69.Requires.Achievements) do
					if table.find(l_ReplicaDataModule_0.data.Achievements, v73) then
						if l_NeedAll_0 ~= true then
							v70 = true;
						end;
					elseif l_NeedAll_0 == true then
						v70 = false;
					elseif not l_NeedAll_0 then
						for _, v75 in pairs(l_ReplicaDataModule_0.data.Achievements) do
							if v75 == v73 then
								v70 = true;
							end;
						end;
					end;
				end;
				if v70 and v68 == "Backdoor" then
					print("Backdoor floor access confirmed!");
					local l_workspace_FirstChild_0 = workspace:FindFirstChild("StarForcefield", true);
					if l_workspace_FirstChild_0 then
						l_workspace_FirstChild_0:Destroy();
					end;
				end;
			end;
			if v70 then
				table.insert(v65, v68);
				v64 = v64 + 1;
			end;
		end;
	end;
	table.sort(v65, function(v77, v78)
		return l_AccessibleFloors_0[v78].Sort > l_AccessibleFloors_0[v77].Sort;
	end);
	if v64 > 1 then
		v19.cef.FullyLocked.Size = UDim2.new(1, 0, 0.6, 0);
		v61 = true;
	end;
	v19.cef.Floors.Visible = v61;
	if l_ReplicaDataModule_0.data and l_ReplicaDataModule_0.data.Achievements and v60 then
		v19.cef.Confirm.Info.Visible = true;
		v19.cef.Confirm.TextXAlignment = Enum.TextXAlignment.Left;
		v19.cef.Modifiers.Visible = true;
		v19.cef.FullyLocked.Visible = false;
		for _, v80 in pairs(v19.cef.Modifiers:GetChildren()) do
			if (v80:IsA("Frame") or v80:IsA("TextButton")) and v80.Visible then
				v80:Destroy();
			end;
		end;
		for _, v82 in pairs(l_Modifiers_0.categories) do
			local v83 = v19.cef.Modifiers.Separator:Clone();
			v83.Visible = true;
			v83.LayoutOrder = (v82.sort + 1) * 1000 - 1;
			v83.Parent = v19.cef.Modifiers;
		end;
		for _, v85 in pairs(l_Modifiers_0.mods) do
			local l_v85_Info_0 = v85:GetInfo();
			local v87 = v19.cef.Modifiers.Template:Clone();
			v87.Visible = true;
			v87.Name = l_v85_Info_0.Name;
			v87.LayoutOrder = l_v85_Info_0.Sort + l_Modifiers_0.categories[l_v85_Info_0.Category].sort * 1000;
			v87.Size = UDim2.new(1, 0, 0, v19.cef.Modifiers.AbsoluteSize.Y * 0.15 + 2);
			if v52 == "mobile" then
				v87.Size = UDim2.new(1, 0, 0, v19.cef.Modifiers.AbsoluteSize.Y * 0.2 + 2);
			end;
			v87.Text = l_v85_Info_0.Title;
			v87.BackgroundColor3 = l_v85_Info_0.Color;
			v87.TextColor3 = l_v85_Info_0.Color;
			v87.UIStroke.Color = l_v85_Info_0.Color;
			v87:SetAttribute("Merge", l_v85_Info_0.Merge);
			v87:SetAttribute("Solo", l_v85_Info_0.Solo);
			local v88 = false;
			do
				local l_v88_0 = v88;
				pcall(function()
					if v85.Unlock ~= nil then
						v87.Locked.Visible = true;
						l_v88_0 = true;
						if l_ReplicaDataModule_0.data then
							pcall(function()
								for _, v91 in pairs(l_ReplicaDataModule_0.data.Achievements) do
									if v91 == v85.Unlock then
										l_v88_0 = false;
										return ;
									end;
								end;
							end);
						end;
						if game.GameId == 3833818265 then
							l_v88_0 = false;
						end;
						if v85.Unlock == "EscapeFools" and not game.ReplicatedStorage.RemotesFolder.IsNotPrivateServer:InvokeServer() then
							l_v88_0 = false;
						end;
						if l_v88_0 then
							local v92 = l_Achievements_0[v85.Unlock];
							v87.Locked.Desc.Text = "Requires '" .. (v92 ~= nil and v92.Title or "???") .. "'" .. (game.GameId == 3833818265 and " [UNLOCKED FOR TESTING]" or "");
							v87.Locked.Visible = true;
							return ;
						else
							v87.Locked.Visible = false;
						end;
					end;
				end);
				if l_v85_Info_0.Bonus < 0 then
					v87.Info.KnobPenalty.Visible = true;
					v87.Info.KnobPenalty.Text = l_v85_Info_0.Bonus .. "%";
				else
					v87.Info.KnobBonus.Visible = true;
					v87.Info.KnobBonus.Text = "+" .. l_v85_Info_0.Bonus .. "%";
				end;
				for v93, v94 in pairs(l_v85_Info_0.Penalties) do
					local l_FirstChild_1 = v87.Info:FindFirstChild(v93);
					if l_FirstChild_1 then
						l_FirstChild_1.Visible = v94;
					end;
				end;
				if v52 == "mobile" then
					v87.Connector.Size = UDim2.new(0, 2, 1, 2);
					v87.ConnectorOut.Size = UDim2.new(0.02, 0, 0, 2);
					v87.UIStroke.Thickness = 2;
					v19.cef.Modifiers.UIListLayout.Padding = UDim.new(0, 4);
				end;
				if l_v85_Info_0.Connect ~= nil then
					v87.ConnectorOut.Visible = true;
					v87.Connector.AnchorPoint = Vector2.new(0.5, l_v85_Info_0.Connect);
					if l_v85_Info_0.Connect == 0.5 then
						v87.Connector.Size = UDim2.new(0, 4, 1.3, 4);
						if v52 == "mobile" then
							v87.Connector.Size = UDim2.new(0, 2, 1.3, 2);
						end;
					end;
					v87.Connector.Visible = true;
				end;
				local function v102(_)
					v19.cef.Preview.Title.Text = l_v85_Info_0.Title;
					v19.cef.Preview.Desc.Text = l_v85_Info_0.Desc;
					v19.cef.Preview.BackgroundColor3 = l_v85_Info_0.Color;
					v19.cef.Preview.Title.TextColor3 = l_v85_Info_0.Color;
					v19.cef.Preview.Desc.TextColor3 = l_v85_Info_0.Color;
					v19.cef.Preview.BackgroundTransparency = v87:GetAttribute("Enabled") and 0.8 or 0.95;
					for _, v98 in pairs(v19.cef.Preview.Info:GetChildren()) do
						if v98:IsA("TextLabel") or v98:IsA("ImageLabel") then
							v98.Visible = false;
						end;
					end;
					if l_v85_Info_0.Bonus < 0 then
						v19.cef.Preview.Info.KnobPenalty.Visible = true;
						v19.cef.Preview.Info.KnobPenalty.Text = l_v85_Info_0.Bonus .. "%";
					else
						v19.cef.Preview.Info.KnobBonus.Visible = true;
						v19.cef.Preview.Info.KnobBonus.Text = "+" .. l_v85_Info_0.Bonus .. "%";
					end;
					for v99, v100 in pairs(l_v85_Info_0.Penalties) do
						local l_FirstChild_2 = v19.cef.Preview.Info:FindFirstChild(v99);
						if l_FirstChild_2 then
							l_FirstChild_2.Visible = v100;
						end;
					end;
					v19.cef.Preview.Visible = true;
					v19.cef.Stats.Visible = false;
					task.delay(0.1, function()
						v59 = v59 + 1;
					end);
				end;
				v87.Parent = v19.cef.Modifiers;
				if not l_v88_0 then
					v87.MouseEnter:Connect(v102);
					v87.SelectionGained:Connect(v102);
					v87.MouseButton1Down:Connect(function()
						local v103 = not (v87:GetAttribute("Enabled") or false);
						v87:SetAttribute("Enabled", v103);
						v87.BackgroundTransparency = v103 and 0.7 or 0.9;
						v87.UIStroke.Enabled = v103;
						v87.TextTransparency = 0;
						v58 = {
							penalties = {}, 
							mods = {}
						};
						for _, v105 in pairs(v19.cef.Modifiers:GetChildren()) do
							if v105:IsA("TextButton") and v105.Visible and v105:GetAttribute("Solo") and v105 ~= v87 then
								v105.TextTransparency = 0.8;
								v105.BackgroundTransparency = 0.9;
								v105.UIStroke.Enabled = false;
								v105:SetAttribute("Enabled", false);
							end;
						end;
						if not (l_v85_Info_0.Merge == nil) or l_v85_Info_0.Solo == true then
							for _, v107 in pairs(v19.cef.Modifiers:GetChildren()) do
								if v107:IsA("TextButton") and (not (not v107.Visible or v107:GetAttribute("Merge") ~= v87:GetAttribute("Merge")) or l_v85_Info_0.Solo) then
									if v107 ~= v87 then
										v107.TextTransparency = v103 and 0.8 or 0;
										v107.BackgroundTransparency = 0.9;
										v107.UIStroke.Enabled = false;
										v107:SetAttribute("Enabled", false);
									end;
									if l_v85_Info_0.Solo ~= true then
										local v108 = Color3.fromRGB(103, 73, 63);
										if v103 then
											v108 = v87.BackgroundColor3;
										end;
										for _, v110 in pairs(v107:GetChildren()) do
											if not (v110.Name ~= "Connector") or v110.Name == "ConnectorOut" then
												v110.BackgroundColor3 = v108;
											end;
										end;
									end;
								end;
							end;
						end;
						for _, v112 in pairs(v19.cef.Modifiers:GetChildren()) do
							if v112:IsA("TextButton") and v112.Visible and v112:GetAttribute("Enabled") then
								table.insert(v58.mods, v112.Name);
								for _, v114 in pairs(v112.Info:GetChildren()) do
									if v114.Name ~= "KnobBonus" and v114.Name ~= "KnobPenalty" and v114:IsA("GuiBase2d") and v114.Visible then
										v58.penalties[v114.Name] = true;
									end;
								end;
							end;
						end;
						local v115 = l_Modifiers_0.getPercs(v58.mods);
						v19.cef.Confirm.Info.Desc.Text = #v58.mods;
						v19.cef.Confirm.Info.Desc.Visible = #v58.mods >= 1;
						v19.cef.Confirm.Info.ModIcon.Visible = #v58.mods >= 1;
						v19.cef.Confirm.Info.KnobBonus.Text = (v115 < 0 and "-" or "+") .. math.abs(v115) .. "%";
						v19.cef.Confirm.Info.NoProgress.Visible = v58.penalties.NoProgress or false;
						v19.cef.Confirm.Info.NoRift.Visible = v58.penalties.NoRift or false;
						v102();
					end);
				end;
			end;
		end;
		if not l_AccessibleFloors_0[v63].Moddable then
			v19.cef.FullyLocked.Visible = true;
			if v60 then
				v19.cef.FullyLocked.Desc.Text = "Modifiers are disabled on this floor.";
				if v63 == "Mines" then
					v19.cef.FullyLocked.Desc.Text = "Modifiers for this floor are coming soon!";
				end;
			else
				v19.cef.FullyLocked.Desc.Text = "";
			end;
			v19.cef.Confirm.Info.Visible = false;
			v19.cef.Confirm.TextXAlignment = Enum.TextXAlignment.Center;
			v19.cef.Modifiers.Visible = false;
			v19.cef.FullyLocked.Visible = true;
			v19.cef.Preview.Visible = false;
		elseif v60 then
			v19.cef.FullyLocked.Desc.Text = "";
		else
			v19.cef.FullyLocked.Desc.Text = "Requires 'Rock Bottom' Achievement";
		end;
		task.wait();
		for _, v117 in pairs(v19.cef.Modifiers:GetChildren()) do
			if (v117:IsA("Frame") or v117:IsA("TextButton")) and v117.Visible then
				local v118 = -999999999;
				local v119 = 999999999;
				local v120 = nil;
				local v121 = nil;
				for _, v123 in pairs(v19.cef.Modifiers:GetChildren()) do
					if v123:IsA("TextButton") and v123.Visible and v123 ~= v117 then
						if v118 < v123.LayoutOrder and v123.LayoutOrder < v117.LayoutOrder then
							v120 = v123;
							v118 = v123.LayoutOrder;
						end;
						if v123.LayoutOrder < v119 and v123.LayoutOrder > v117.LayoutOrder then
							v121 = v123;
							v119 = v123.LayoutOrder;
						end;
					end;
				end;
				v117.NextSelectionUp = v120;
				v117.NextSelectionDown = v121;
			end;
		end;
		return ;
	else
		v19.cef.Confirm.Info.Visible = false;
		v19.cef.Confirm.TextXAlignment = Enum.TextXAlignment.Center;
		v19.cef.Modifiers.Visible = false;
		v19.cef.FullyLocked.Visible = true;
		v19.cef.Preview.Visible = false;
		if l_ReplicaDataModule_0.data and l_ReplicaDataModule_0.data.Achievements then
			if not l_AccessibleFloors_0[v63].Moddable then
				v19.cef.FullyLocked.Visible = true;
				if v60 then
					v19.cef.FullyLocked.Desc.Text = "Modifiers are disabled on this floor.";
					if v63 == "Mines" then
						v19.cef.FullyLocked.Desc.Text = "Modifiers for this floor are coming soon!";
					end;
				else
					v19.cef.FullyLocked.Desc.Text = "";
				end;
				v19.cef.Confirm.Info.Visible = false;
				v19.cef.Confirm.TextXAlignment = Enum.TextXAlignment.Center;
				v19.cef.Modifiers.Visible = false;
				v19.cef.FullyLocked.Visible = true;
				v19.cef.Preview.Visible = false;
				return ;
			elseif v60 then
				v19.cef.FullyLocked.Desc.Text = "";
				return ;
			else
				v19.cef.FullyLocked.Desc.Text = "Requires 'Rock Bottom' Achievement";
				return ;
			end;
		else
			v19.cef.FullyLocked.Desc.Text = "Loading data...";
			return ;
		end;
	end;
end;

doFloorStuff = function(v132)
	local v133 = table.find(v65, v63) + v132;
	if v64 < v133 then
		v133 = 1;
	elseif v133 < 1 then
		v133 = v64;
	end;
	v63 = v65[v133];
	for _, v135 in pairs(l_Floors_0:GetChildren()) do
		if v135:IsA("TextLabel") then
			v135.Visible = v135.Name == v63;
			if v135.Visible then
				l_Floors_0.UIStroke.Color = v135.BackgroundColor3;
				l_Floors_0.NavLeft.ImageColor3 = v135.BackgroundColor3;
				l_Floors_0.NavRight.ImageColor3 = v135.BackgroundColor3;
			end;
		end;
	end;
	resetMods();
end;
