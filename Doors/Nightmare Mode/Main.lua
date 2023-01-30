local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))();
local Library = Instance.new("ScreenGui");
Library.Parent = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui");
local NotificationHandler = Instance.new("Frame");
local UIListLayout = Instance.new("UIListLayout");
NotificationHandler.Name = "NotificationHandler";
NotificationHandler.Parent = Library;
NotificationHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
NotificationHandler.BackgroundTransparency = 1;
NotificationHandler.Position = UDim2.new(0, 0, 0.8, 0);
NotificationHandler.Size = UDim2.new(1, 0, 0.0925925896, 0);
UIListLayout.Parent = NotificationHandler;
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
UIListLayout.Padding = UDim.new(0.100000001, 0);
CreateNotification = function(Text, Color)
	Text = Text or "❌💬Error Loading A Notification.. 💬❌";
	Color = Color3.fromRGB(244, 181, 153);
	local Typewriter_effect = Instance.new("Sound");
	local Notification = Instance.new("TextLabel");
	if (Color == "nil") then
		Color = Color3.fromRGB(244, 181, 153);
	end
	Notification.Name = "Notification";
	Notification.Parent = NotificationHandler;
	Notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Notification.BackgroundTransparency = 1;
	Notification.Size = UDim2.new(1, 0, 0.332086951, 0);
	Notification.Font = Enum.Font.Oswald;
	Notification.Text = Text;
	Notification.TextColor3 = Color;
	Notification.TextScaled = true;
	Notification.TextSize = 14;
	Notification.TextStrokeTransparency = 1;
	Notification.TextWrapped = true;
	wait(3);
	game.TweenService:Create(Notification, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextTransparency=1}):Play();
	wait(1.75);
	Notification:Remove();
end;

CreateNotification("📜Loading Scripts📜")

local Background_sound = Instance.new("Sound");
local Music = "https://cdn.discordapp.com/attachments/970078853127110677/1068938427204112474/Scary.mp3";
Background_sound.SoundId = LoadCustomAsset(Music);
Background_sound.Playing = true;
Background_sound.Looped = true;
Background_sound.Volume = 0.25;
Background_sound.Parent = workspace;

local SeekMusic = workspace:FindFirstChild("Ambience_Seek");
local SeekSong = "https://cdn.discordapp.com/attachments/970078853127110677/1069681807940911185/Music.mp3";
SeekMusic.SoundId = LoadCustomAsset(SeekSong);

local FigureMusic = workspace:FindFirstChild("Ambience_Figure");
local FigureSong = "https://cdn.discordapp.com/attachments/1066050482075861083/1069290286498459728/Figure.mp3";
FigureMusic.SoundId = LoadCustomAsset(FigureSong);

function Rush(Entity)
	local RushNew = Entity:FindFirstChild("RushNew");
	RushNew.Attachment.BlackTrail.Color = Color3.new(0.356863, 0, 0);
	RushNew.Attachment.ParticleEmitter.Texture = "http://www.roblox.com/asset/?id=12281732171";
end;
AddWindowDecorations = function(Decorations)
	if (Decorations.Name == "Skybox") then
		Decorations.Color = Color3.fromRGB(255, 255, 0);
		Decorations.Material = Enum.Material.Neon;
	end
	if (Decorations.Name == "Window") then
		if Decorations:FindFirstChild("Particles") then
			local Part_Particles = Decorations:FindFirstChild("Particles");
			local Blood = game:GetObjects("rbxassetid://12302764071")[1];
			Blood.Parent = Part_Particles;
			if Part_Particles:FindFirstChild("RainParticle") then
				Part_Particles.Orientation = Vector3.new(0, Decorations.Glass.Orientation.Y, 180);
				game:GetService("Debris"):AddItem(Part_Particles:FindFirstChild("RainParticle"), 0.2);
			end
		end
	end
end;
local Timothy = game:GetObjects("rbxassetid://12291843071")[1];
Timothy.Parent = game:GetService("ReplicatedStorage"):WaitForChild("Entities");
game:GetService("Debris"):AddItem(game:GetService("ReplicatedStorage"):WaitForChild("Entities").Spider, 0);
local Screech = game:GetObjects("rbxassetid://12282003087")[1];
Screech.Parent = game:GetService("ReplicatedStorage"):WaitForChild("Entities");
game:GetService("Debris"):AddItem(game:GetService("ReplicatedStorage"):WaitForChild("Entities").Screech, 0);
local Glitch = game:GetObjects("rbxassetid://12291798192")[1];
Glitch.Parent = game:GetService("ReplicatedStorage"):WaitForChild("Entities");
game:GetService("Debris"):AddItem(game:GetService("ReplicatedStorage"):WaitForChild("Entities").Glitch, 0);

workspace.ChildAdded:Connect(function(entity)
	if entity.Name == "RushMoving" then
		Rush(entity);
	end
end)

for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
	if (room.Name == "0") then
		if room.Parts:FindFirstChild("FrontDesk") then
			for i, paper in pairs(room.Parts:FindFirstChild("FrontDesk"):GetChildren()) do
				if (paper.Name == "Paper") then
					local Decal = Instance.new("Decal");
					local inPrompt = false;
					local Prompt = game:GetObjects("rbxassetid://12019597028")[1];
					Decal.Parent = paper;
					Decal.Face = Enum.NormalId.Top;
					Decal.Texture = "http://www.roblox.com/asset/?id=183599976";
				end
			end
		end
	end
end
connect = function(asset)
	for _, v in pairs(asset:GetDescendants()) do
		for i, a in pairs(workspace.CurrentRooms:GetChildren()) do
			if a:FindFirstChild("RainSky") then
				if (v.Name == "Bush") then
					v.BrickColor = BrickColor.new("Really red");
				end
				if (v.Name == "Courtyard_Tree") then
					game.ReplicatedStorage:FindFirstChild("Sounds")["LA_The Courtyard"].Playing = true
					game.ReplicatedStorage:FindFirstChild("Sounds")["LA_The Courtyard"].Looped = true
					v.Leaves.BrickColor = BrickColor.new("Really red");
				end
				if ((v.Name == "Floor") and v:IsA("BasePart") and (v.Material == Enum.Material.Grass)) then
					v.BrickColor = BrickColor.new("Really red");
					v.Material = Enum.Material.CrackedLava;
				end
			end
		end
	end
end;

connect(workspace.CurrentRooms);
workspace.CurrentRooms.ChildAdded:Connect(function(child)
	connect(child);
end);
local FakeDoorName = "FakeDoor_Hotel";
local DoorReplicator = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Door%20Replication/Source.lua"))();
local Player = game.Players.LocalPlayer;
local PI_Folder = Instance.new("Folder", game.ReplicatedStorage);
PI_Folder.Name = "Possibleitems";
local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacteAdded:Wait();
local hum = char:WaitForChild("Humanoid");
SetupDoor = function(fakedoor)
	local newdoor = DoorReplicator.CreateDoor({Sign=false,Light=false}).model;
	DoorReplicator.ReplicateDoor({Config={GuidingLight=true,Model=newdoor}});
	local room = game:GetObjects("rbxassetid://12303988072")[1]:Clone();
	room.PrimaryPart = room.RoomStart;
	room.Parent = workspace.CurrentRooms:FindFirstChild(tostring(Player:GetAttribute("CurrentRoom")));
	local cf = fakedoor.Collision.CFrame;
	newdoor:PivotTo(cf);
	fakedoor:Destroy();
	DoorReplicator.ReplicateDoor({Config={GuidingLight=true,Model=newdoor}});
	room:PivotTo(cf);
	if (room.Name == "ExtraRoom_1") then
		local Start = room.RoomStart;
		Start.Touched:Connect(function()
			CreateNotification("It Dosn't Feel Safe In Here..");
			CreateNotification("I Don't Think I Should Explore..");
		end);
	end
end;
for _, fakedoor in pairs(workspace.CurrentRooms:GetDescendants()) do
	local RNG = math.random(0, 2);
	if (RNG == 0) then
		if (fakedoor.Name == FakeDoorName) then
			SetupDoor(fakedoor);
		end
	end
end
workspace.CurrentRooms.ChildAdded:Connect(function(room)
	for _, fakedoor in pairs(room:GetDescendants()) do
		local RNG = math.random(0, 2);
		if (RNG == 0) then
			if (fakedoor.Name == FakeDoorName) then
				SetupDoor(fakedoor);
			end
		end
	end
end);

function addHaltDecor(obj)
	wait(2)
	local Halt = obj.Halt
	Halt.Color = Color3.new(0.235294, 0, 0)
	Halt.PointLight.Color = Color3.new(1, 0, 0.0156863)
	Halt.Attachment.ParticleEmitter.Color = Color3.new(1, 0, 0)
end

game.Workspace.Camera.ChildAdded:Connect(function(c)
	if c.Name == "Shade" then
		addHaltDecor(c)
	end
end)

local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart

function AddBodys(obj)        
	local Body = game:GetObjects("rbxassetid://12305239584")[1]
	Body.Parent = obj
	Body.CFrame = obj.CFrame * CFrame.new(
		math.random(-obj.Size.X/3, obj.Size.X/3),math.random(-obj.Size.Y/3, obj.Size.Y/3),math.random(-obj.Size.Z/3, obj.Size.Z/3)
	)
	Body.Orientation = Vector3.new(0, math.random(1,180), 0)
end

for i, table in pairs(game.Workspace.CurrentRooms:GetDescendants()) do
	if table.Name == "Table" then

		local Part = Instance.new("Part")
		Part.CFrame = table:WaitForChild("Main").CFrame * CFrame.new(0, 2, 0)
		Part.Transparency = 1
		Part.Size = Vector3.new(table:WaitForChild("Main").Size.X, 0.2, table:WaitForChild("Main").Size.Z)
		Part.Parent = table
		Part.Name = "Body Zone"
		Part.Anchored = true
		wait(0.1)
		AddBodys(Part)
	end
	if table.Name == "Body Zone" then
		table:Remove()
	end
end

game.Workspace.CurrentRooms.ChildAdded:Connect(function(Child)
	wait(2)
	for i,v in pairs(Child:GetDescendants()) do
		if v.Name == "Table" then
			local Part = Instance.new("Part")
			Part.CFrame = v:WaitForChild("Main").CFrame * CFrame.new(0, 2, 0)
			Part.Transparency = 1
			Part.Size = Vector3.new(v:WaitForChild("Main").Size.X, 0.2, v:WaitForChild("Main").Size.Z)
			Part.Parent = v
			Part.Name = "Body Zone"
			Part.Anchored = true
			wait(0.1)
			AddBodys(Part)
		end
	end
end)

function AddRoomsDecor(obj)
	local Noob = game:GetObjects("rbxassetid://12320669592")[1]
	Noob.Parent = obj
	Noob.CFrame = obj:WaitForChild("Stand").CFrame * CFrame.new(0.1,-1.2,-0.5)
	Noob.Orientation = Vector3.new(0,obj:WaitForChild("Stand").Orientation.Y,-180)
end

function ChangeLights(obj)
	obj.Color = Color3.new(0.333333, 0, 0)
end

for i, object in pairs(workspace:WaitForChild("CurrentRooms"):GetDescendants()) do
	if object.Name == "LightStand" then
		AddRoomsDecor(object)
	elseif object.Name == "Neon" then
		ChangeLights(object)
	end
end

workspace.CurrentRooms.ChildAdded:Connect(function(child)
	wait(2)
	for i,v in pairs(child:GetDescendants()) do
		if v.Name == "LightStand" then
			AddRoomsDecor(v)
		elseif v.Name == "Neon" then
			ChangeLights(v)
		end
	end
end)

function Figure50(Entity)
	if Entity.Name == "FigureRagdoll" then
		local Character = game:GetObjects("rbxassetid://12321298527")[1]
		local Character2 = game:GetObjects("rbxassetid://12321298527")[1]
		local Figure = workspace.CurrentRooms:FindFirstChild("50"):WaitForChild("FigureSetup"):WaitForChild("FigureRagdoll")				
		local Figure2 = game.ReplicatedStorage.JumpscareModels.Figure.FigureAnimatedWelded	
		
		-- Make Figure Transparent --

		Figure:WaitForChild("Head").Transparency = 1					
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Transparency = 1					
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Blood.Transparency = 1				
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Gums.Transparency = 1				
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Teeth.Transparency = 1				
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Teeth.Blood.Transparency = 1					
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Veins.Transparency = 1
		Figure:WaitForChild("LeftFoot").Transparency = 1			
		Figure:WaitForChild("LeftHand").Transparency = 1				
		Figure:WaitForChild("LeftLowerArm").Transparency = 1				
		Figure:WaitForChild("LeftLowerArm").Blister.Transparency = 1				
		Figure:WaitForChild("LeftLowerLeg").Transparency = 1			
		Figure:WaitForChild("LeftUpperLeg").Transparency = 1			
		Figure:WaitForChild("LeftUpperArm").Transparency = 1			
		Figure:WaitForChild("LeftMiddleArm").Transparency = 1		
		Figure:WaitForChild("LeftMiddleArm").Blister.Transparency = 1		
		Figure:WaitForChild("LeftMiddleLeg").Transparency = 1	
		Figure:WaitForChild("LeftMiddleLeg").Blister.Transparency = 1	
		Figure:WaitForChild("Head").Transparency = 1
		Figure:WaitForChild("RightFoot").Transparency = 1				
		Figure:WaitForChild("RightHand").Transparency = 1			
		Figure:WaitForChild("RightLowerArm").Transparency = 1			
		Figure:WaitForChild("RightLowerArm").Blister.Transparency = 1			
		Figure:WaitForChild("RightLowerLeg").Transparency = 1			
		Figure:WaitForChild("RightLowerLeg").Blister.Transparency = 1			
		Figure:WaitForChild("RightUpperLeg").Transparency = 1			
		Figure:WaitForChild("RightUpperArm").Transparency = 1			
		Figure:WaitForChild("RightUpperArm").Blister.Transparency = 1			
		Figure:WaitForChild("RightMiddleArm").Transparency = 1				
		Figure:WaitForChild("RightMiddleLeg").Transparency = 1				
		Figure:WaitForChild("RightMiddleLeg").Blister.Transparency = 1			
		Figure:WaitForChild("Root").Transparency = 1			
		Figure:WaitForChild("Torso").Transparency = 1			
		Figure:WaitForChild("Torso").RibCage.Transparency = 1

		Character.Parent = Figure
		Character.Body.Weld.Part1 = Figure

		-- Jumpscare Character --

		Figure2:FindFirstChild("Head").Transparency = 1	
		Figure2:FindFirstChild("Head").FakeHead.Transparency = 1	
		Figure2:FindFirstChild("Head").FakeHead.Blood.Transparency = 1
		Figure2:FindFirstChild("Head").FakeHead.Gums.Transparency = 1
		Figure2:FindFirstChild("Head").FakeHead.Teeth.Transparency = 1
		Figure2:FindFirstChild("Head").FakeHead.Teeth.Blood.Transparency = 1	
		Figure2:FindFirstChild("Head").FakeHead.Veins.Transparency = 1
		Figure2:FindFirstChild("LeftFoot").Transparency = 1
		Figure2:FindFirstChild("LeftHand").Transparency = 1
		Figure2:FindFirstChild("LeftLowerArm").Transparency = 1
		Figure2:FindFirstChild("LeftLowerArm").Blister.Transparency = 1
		Figure2:FindFirstChild("LeftLowerLeg").Transparency = 1
		Figure2:FindFirstChild("LeftUpperLeg").Transparency = 1
		Figure2:FindFirstChild("LeftUpperArm").Transparency = 1
		Figure2:FindFirstChild("LeftMiddleArm").Transparency = 1
		Figure2:FindFirstChild("LeftMiddleArm").Blister.Transparency = 1
		Figure2:FindFirstChild("LeftMiddleLeg").Transparency = 1
		Figure2:FindFirstChild("LeftMiddleLeg").Blister.Transparency = 1
		Figure2:FindFirstChild("Head").Transparency = 1
		Figure2:FindFirstChild("RightFoot").Transparency = 1
		Figure2:FindFirstChild("RightHand").Transparency = 1
		Figure2:FindFirstChild("RightLowerArm").Transparency = 1
		Figure2:FindFirstChild("RightLowerArm").Blister.Transparency = 1
		Figure2:FindFirstChild("RightLowerLeg").Transparency = 1
		Figure2:FindFirstChild("RightLowerLeg").Blister.Transparency = 1
		Figure2:FindFirstChild("RightUpperLeg").Transparency = 1
		Figure2:FindFirstChild("RightUpperArm").Transparency = 1
		Figure2:FindFirstChild("RightUpperArm").Blister.Transparency = 1
		Figure2:FindFirstChild("RightMiddleArm").Transparency = 1
		Figure2:FindFirstChild("RightMiddleLeg").Transparency = 1
		Figure2:FindFirstChild("RightMiddleLeg").Blister.Transparency = 1
		Figure2:FindFirstChild("Root").Transparency = 1
		Figure2:FindFirstChild("Torso").Transparency = 1
		Figure2:FindFirstChild("Torso").RibCage.Transparency = 1

		Character2.Parent = Figure2
		Character2.Body.Weld.Part1 = Figure2
	end
end

function Figure100(Entity)
	if Entity.Name == "FigureRagdoll" then
		local Character = game:GetObjects("rbxassetid://12321298527")[1]
		local Character2 = game:GetObjects("rbxassetid://12321298527")[1]
		local Figure = workspace.CurrentRooms:FindFirstChild("100"):WaitForChild("FigureSetup"):WaitForChild("FigureRagdoll")
		local Figure2 = workspace.CurrentRooms:FindFirstChild("100"):WaitForChild("ElevatorCar"):WaitForChild("Figure"):WaitForChild("FigureAnimatedWelded")

		-- Make Figure Transparent --

		Figure:WaitForChild("Head").Transparency = 1					
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Transparency = 1					
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Blood.Transparency = 1				
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Gums.Transparency = 1				
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Teeth.Transparency = 1				
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Teeth.Blood.Transparency = 1					
		Figure:WaitForChild("Head"):WaitForChild("FakeHead").Veins.Transparency = 1
		Figure:WaitForChild("LeftFoot").Transparency = 1			
		Figure:WaitForChild("LeftHand").Transparency = 1				
		Figure:WaitForChild("LeftLowerArm").Transparency = 1				
		Figure:WaitForChild("LeftLowerArm").Blister.Transparency = 1				
		Figure:WaitForChild("LeftLowerLeg").Transparency = 1			
		Figure:WaitForChild("LeftUpperLeg").Transparency = 1			
		Figure:WaitForChild("LeftUpperArm").Transparency = 1			
		Figure:WaitForChild("LeftMiddleArm").Transparency = 1		
		Figure:WaitForChild("LeftMiddleArm").Blister.Transparency = 1		
		Figure:WaitForChild("LeftMiddleLeg").Transparency = 1	
		Figure:WaitForChild("LeftMiddleLeg").Blister.Transparency = 1	
		Figure:WaitForChild("Head").Transparency = 1
		Figure:WaitForChild("RightFoot").Transparency = 1				
		Figure:WaitForChild("RightHand").Transparency = 1			
		Figure:WaitForChild("RightLowerArm").Transparency = 1			
		Figure:WaitForChild("RightLowerArm").Blister.Transparency = 1			
		Figure:WaitForChild("RightLowerLeg").Transparency = 1			
		Figure:WaitForChild("RightLowerLeg").Blister.Transparency = 1			
		Figure:WaitForChild("RightUpperLeg").Transparency = 1			
		Figure:WaitForChild("RightUpperArm").Transparency = 1			
		Figure:WaitForChild("RightUpperArm").Blister.Transparency = 1			
		Figure:WaitForChild("RightMiddleArm").Transparency = 1				
		Figure:WaitForChild("RightMiddleLeg").Transparency = 1				
		Figure:WaitForChild("RightMiddleLeg").Blister.Transparency = 1			
		Figure:WaitForChild("Root").Transparency = 1			
		Figure:WaitForChild("Torso").Transparency = 1			
		Figure:WaitForChild("Torso").RibCage.Transparency = 1

		Character.Parent = Figure
		Character.Body.Weld.Part1 = Figure

		-- Jumpscare Character --

		Figure2:FindFirstChild("Head").Transparency = 1	
		Figure2:FindFirstChild("Head").FakeHead.Transparency = 1	
		Figure2:FindFirstChild("Head").FakeHead.Blood.Transparency = 1
		Figure2:FindFirstChild("Head").FakeHead.Gums.Transparency = 1
		Figure2:FindFirstChild("Head").FakeHead.Teeth.Transparency = 1
		Figure2:FindFirstChild("Head").FakeHead.Teeth.Blood.Transparency = 1	
		Figure2:FindFirstChild("Head").FakeHead.Veins.Transparency = 1
		Figure2:FindFirstChild("LeftFoot").Transparency = 1
		Figure2:FindFirstChild("LeftHand").Transparency = 1
		Figure2:FindFirstChild("LeftLowerArm").Transparency = 1
		Figure2:FindFirstChild("LeftLowerArm").Blister.Transparency = 1
		Figure2:FindFirstChild("LeftLowerLeg").Transparency = 1
		Figure2:FindFirstChild("LeftUpperLeg").Transparency = 1
		Figure2:FindFirstChild("LeftUpperArm").Transparency = 1
		Figure2:FindFirstChild("LeftMiddleArm").Transparency = 1
		Figure2:FindFirstChild("LeftMiddleArm").Blister.Transparency = 1
		Figure2:FindFirstChild("LeftMiddleLeg").Transparency = 1
		Figure2:FindFirstChild("LeftMiddleLeg").Blister.Transparency = 1
		Figure2:FindFirstChild("Head").Transparency = 1
		Figure2:FindFirstChild("RightFoot").Transparency = 1
		Figure2:FindFirstChild("RightHand").Transparency = 1
		Figure2:FindFirstChild("RightLowerArm").Transparency = 1
		Figure2:FindFirstChild("RightLowerArm").Blister.Transparency = 1
		Figure2:FindFirstChild("RightLowerLeg").Transparency = 1
		Figure2:FindFirstChild("RightLowerLeg").Blister.Transparency = 1
		Figure2:FindFirstChild("RightUpperLeg").Transparency = 1
		Figure2:FindFirstChild("RightUpperArm").Transparency = 1
		Figure2:FindFirstChild("RightUpperArm").Blister.Transparency = 1
		Figure2:FindFirstChild("RightMiddleArm").Transparency = 1
		Figure2:FindFirstChild("RightMiddleLeg").Transparency = 1
		Figure2:FindFirstChild("RightMiddleLeg").Blister.Transparency = 1
		Figure2:FindFirstChild("Root").Transparency = 1
		Figure2:FindFirstChild("Torso").Transparency = 1
		Figure2:FindFirstChild("Torso").RibCage.Transparency = 1

		Character2.Parent = Figure2
		Character2.Body.Weld.Part1 = Figure2
	end
end

function AddSeekDecor(e)
	if e.Name == "SeekRig" then
		local Skeleton = game:GetObjects("rbxassetid://12320290548")[1]
		Skeleton.Parent = e
		Skeleton.Skeleton.Weld.Part1 = e:FindFirstChild("Head")
		e:FindFirstChild("Head").Transparency = 1
		e:FindFirstChild("Head"):FindFirstChild("Black").Transparency = 1
		e:FindFirstChild("Head"):FindFirstChild("Eye").Transparency = 1
		e:FindFirstChild("Head"):FindFirstChild("Eye"):FindFirstChild("Decal").Transparency = 1
		e:FindFirstChild("LeftLowerArm").Transparency = 1
		e:FindFirstChild("LeftLowerLeg").Transparency = 1
		e:FindFirstChild("LeftUpperArm").Transparency = 1
		e:FindFirstChild("LeftUpperLeg").Transparency = 1
		e:FindFirstChild("LowerTorso").Transparency = 1
		e:FindFirstChild("RightLowerArm").Transparency = 1
		e:FindFirstChild("RightLowerLeg").Transparency = 1
		e:FindFirstChild("RightUpperArm").Transparency = 1
		e:FindFirstChild("RightUpperLeg").Transparency = 1
		e:FindFirstChild("UpperTorso").Transparency = 1
		e:FindFirstChild("SeekPuddle").Color = Color3.new(0.176471, 0, 0)
		e:FindFirstChild("SeekPuddle"):FindFirstChild("ParticleHitbox").Color = Color3.new(0.176471, 0, 0)
	end
end

game.Workspace.ChildAdded:Connect(function(child)
	wait(0.2)
	if child.Name == "SeekMoving" then
		local seekrig = child:WaitForChild("SeekRig")
		if seekrig then
			AddSeekDecor(seekrig)
		end
	end
end)

for i,entity in pairs(workspace.CurrentRooms:GetDescendants()) do
	if entity.Name == "50" then
		if entity.FigureSetup:WaitForChild("FigureRagdoll") then
			Figure50(entity)	
		end
	elseif entity.Name == "100" then
		if entity.FigureSetup:WaitForChild("FigureRagdoll") then
			Figure100(entity)	
		end
	end
end

for i,entity in pairs(workspace:GetDescendants()) do
	AddSeekDecor(entity)
end

game.Workspace.CurrentRooms.ChildAdded:Connect(function(child)
	wait(2)
	if child.Name == "50" then
		if child.FigureSetup:WaitForChild("FigureRagdoll") then
			Figure50(child)	
		end
	elseif child.Name == "100" then
		if child.FigureSetup:WaitForChild("FigureRagdoll") then
			Figure100(child)	
		end
	end
end)

function AddWindowDecor(obj)
	if obj.Name == "Skybox" then
		obj.Color = Color3.fromRGB(91, 0, 0)
		obj.Material = Enum.Material.SmoothPlastic
	end
	if obj.Name == "Window" then
		if obj:FindFirstChild("Particles") then
			local Part_Particles = obj:FindFirstChild("Particles")
			local Particles = game:GetObjects("rbxassetid://12302764071")[1]
			Particles.Parent = Part_Particles

			if Part_Particles:FindFirstChild("RainParticle") then
				Part_Particles.Orientation = Vector3.new(0, obj.Glass.Orientation.Y, 180)
				game:GetService("Debris"):AddItem(Part_Particles:FindFirstChild("RainParticle"), 0.2)
			end
		end
	end
end

for index, Skybox in pairs(game.Workspace.CurrentRooms:GetDescendants()) do
	AddWindowDecor(Skybox)
end

workspace.CurrentRooms.ChildAdded:Connect(function(child)
	game.ReplicatedStorage:FindFirstChild("Sounds")["LA_The Courtyard"].Playing = false
	game.ReplicatedStorage:FindFirstChild("Sounds")["LA_The Courtyard"].Looped = false
	wait(2)
	for i, v in pairs(child:GetDescendants()) do
		AddWindowDecor(v)
	end
end)

local inPrompt = false
local Mask = game:GetObjects("rbxassetid://12306195956")[1]
local Prompt = game:GetObjects("rbxassetid://12019597028")[1]

Mask.Parent = game:GetService("Workspace").CurrentRooms["0"].Assets
Mask.CFrame = game:GetService("Workspace").CurrentRooms["0"].Assets["Desk_Bell"].Base.CFrame * CFrame.new(3, 0, 0)
Prompt.Parent = Mask

Prompt.Triggered:Connect(function()
	if inPrompt == false then
		inPrompt = true
		CreateNotification("😈😈Hello There😈😈")
		CreateNotification("📌📜Your Next On My List📜📌")
		CreateNotification("🙂Better Watch Out Or Else..🙂")
		CreateNotification("🔪🔪🔪😵🗡️🗡️🗡️")
		wait(1)
		inPrompt = false
	end
end)

CreateNotification("✅Successfully Loaded Nightmare Mode!✅")
CreateNotification("🐔Made By ii_matei || Kiwi Bird#8480🐥")
