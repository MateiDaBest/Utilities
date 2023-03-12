local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/MateiDaBest/Utilities/main/Doors/Entity%20Spawner/Source.lua"))()

-- Create entity
local entityTable = Spawner.createEntity({
	CustomName = "Template Entity", -- Custom name of your entity
	Model = "https://github.com/RegularVynixu/Utilities/blob/main/Doors%20Entity%20Spawner/Models/Rush.rbxm?raw=true", -- Can be GitHub file or rbxassetid
	Speed = 100, -- Percentage, 100 = default Rush speed
	DelayTime = 2, -- Time before starting cycles (seconds)
	HeightOffset = 0,
	CanKill = true,
	KillRange = 50,
	BackwardsMovement = false,
	BreakLights = true,
	FlickerLights = {
		true, -- Enabled/Disabled
		1, -- Time (seconds)
	},
	Cycles = {
		Min = 1,
		Max = 4,
		WaitTime = 2,
	},
	CamShake = {
		true, -- Enabled/Disabled
		{3.5, 20, 0.1, 1}, -- Shake values (don't change if you don't know)
		100, -- Shake start distance (from Entity to you)
	},
	Jumpscare = {
		true, -- Enabled/Disabled
		{
			Image1 = "http://www.roblox.com/asset/?id=10483855823", -- Image1 url
			Image2 = "http://www.roblox.com/asset/?id=10483999903", -- Image2 url
			Shake = true,
			Sound1 = {
				10483790459, -- SoundId
				{ Volume = 0.5 }, -- Sound properties
			},
			Sound2 = {
				10483837590, -- SoundId
				{ Volume = 0.5 }, -- Sound properties
			},
			Flashing = {
				true, -- Enabled/Disabled
				Color3.fromRGB(255, 255, 255), -- Color
			},
			Tease = {
				true, -- Enabled/Disabled
				Min = 1,
				Max = 3,
			},
		},
	},
	CustomDialog = {"You can", "put your", "custom death", "message here."}, -- Custom death message
	CustomDialogColor = "Blue" -- Blue or Yellow
})


-----[[  Debug -=- Advanced  ]]-----
entityTable.Debug.OnEntitySpawned = function()
	-- Entity Has Spawned
end

entityTable.Debug.OnEntityDespawned = function()
	-- Entity Has Despawned
end

entityTable.Debug.OnEntityStartMoving = function()
	-- Entity Has Started Moving
end

entityTable.Debug.OnEntityFinishedRebound = function()
	-- Entity Has Finished Rebounding
end

entityTable.Debug.OnEntityEnteredRoom = function(room)
	-- Entity Has Entered Room
end

entityTable.Debug.OnLookAtEntity = function()
	-- Player Looked At Entity
end

entityTable.Debug.OnDeath = function()
	-- Player Died
end
------------------------------------

-- Run the created entity
Spawner.runEntity(entityTable)
