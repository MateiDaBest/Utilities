local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local StarJug = game:GetObjects("rbxassetid://119885581324516")[1]
local speedTweenValue = Instance.new("NumberValue", StarJug)
local debounce = false

StarJug.Parent = Players.LocalPlayer.Backpack
local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local Animations = StarJug:WaitForChild("Animations")
local LoadedAnims = {}

for _, anim in pairs(Animations:GetChildren()) do
    LoadedAnims[anim.Name] = humanoid:LoadAnimation(anim)
    
    if anim.Name == "idle" then
        LoadedAnims[anim.Name].Priority = Enum.AnimationPriority.Idle
        LoadedAnims[anim.Name].Looped = true
    end
end

StarJug.Equipped:Connect(function()
    LoadedAnims["equip"]:Play()
    
    task.wait(LoadedAnims["equip"].Length)
    
    if StarJug:IsDescendantOf(character) then
        LoadedAnims["idle"]:Play()
    end
end)

StarJug.Unequipped:Connect(function()
    if LoadedAnims["idle"].IsPlaying then
        LoadedAnims["idle"]:Stop()
    end
end)

local function cleanupCollisionClone()
    for _, child in pairs(character:GetChildren()) do
        if child.Name == "CollisionClone" then
            child:Destroy()
        end
    end
end

local function createCollisionClone()
    cleanupCollisionClone()
    
    local collisionClone = character.Collision:Clone()
    collisionClone.CanCollide = false
    collisionClone.Massless = true
    collisionClone.Name = "CollisionClone"
    if collisionClone:FindFirstChild("CollisionCrouch") then
        collisionClone.CollisionCrouch:Destroy()
    end

    collisionClone.Parent = character
    return collisionClone
end

StarJug.Activated:Connect(function()
    if debounce then return end
    debounce = true
    
    LoadedAnims["open"]:Play()
    
    character:SetAttribute("Starlight", true)
    character:SetAttribute("StarlightHuge", true)
    
    local speedBoost, speedBoostFinished, mspaint_speed = 22.5, false, false
    local collisionClone
    
    if getgenv().mspaint_loaded then
        mspaint_speed = true
        
        local originalSpeed = getgenv().Linoria.Toggles.SpeedBypass.Value
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if speedBoostFinished then
                conn:Disconnect()
                getgenv().Linoria.Toggles.SpeedBypass:SetValue(originalSpeed)
                return
            end
            if not getgenv().Linoria.Toggles.SpeedBypass.Value then
                getgenv().Linoria.Toggles.SpeedBypass:SetValue(true)
            end
        end)
    else
        collisionClone = createCollisionClone()
        
        task.spawn(function()
            while not speedBoostFinished do
                collisionClone.Massless = not collisionClone.Massless
                task.wait(0.21)
            end
            
            if collisionClone and collisionClone.Parent then
                collisionClone.Massless = true
            end
        end)
    end
    
    speedTweenValue.Value = 35
    local tween = TweenService:Create(speedTweenValue, TweenInfo.new(70, Enum.EasingStyle.Linear), {
        Value = 0
    })
    tween:Play()

    local conn = speedTweenValue:GetPropertyChangedSignal("Value"):Connect(function()
        character:SetAttribute("SpeedBoost", speedTweenValue.Value)
    end)
    
    task.delay(35, function()
        speedBoostFinished = true
        conn:Disconnect()
        tween:Cancel()
        
        if collisionClone and collisionClone.Parent then
            collisionClone:Destroy()
        end
        
        character:SetAttribute("Starlight", false)
        character:SetAttribute("StarlightHuge", false)
        character:SetAttribute("SpeedBoost", 0)
        debounce = false
    end)
end)

cleanupCollisionClone()
