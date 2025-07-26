local script = game.ReplicatedStorage.Packages.EasyVisuals
local l_Presets_0 = script.Presets;
local v1 = {
    Gradient = require(script.Gradient), 
    Stroke = require(script.Stroke), 
    Dropshadow = require(script.Dropshadow), 
    Templates = require(script.GradientTemplates)
};
v1.__index = v1;
v1.CurrentEffects = {};
local v2 = {
    GuiObject = "Visible", 
    ScreenGui = "Enabled", 
    BillboardGui = "Enabled", 
    SurfaceGui = "Enabled"
};
local function _(v3) --[[ Line: 32 ]] --[[ Name: ValidateIsPreset ]]
    -- upvalues: l_Presets_0 (copy)
    return l_Presets_0:FindFirstChild(v3) ~= nil;
end;
v1.new = function(v5, v6, v7, v8, v9, v10, v11, v12) --[[ Line: 36 ]] --[[ Name: new ]]
    -- upvalues: l_Presets_0 (copy), v2 (copy), v1 (copy)
    assert(v5, "UIInstance not provided");
    assert(v6, "EffectType not provided");
    assert(v5:IsA("GuiObject"), "UIInstance is not a GuiObject");
    assert(typeof(v6) == "string", "effectType is not a string");
    assert(l_Presets_0:FindFirstChild(v6) ~= nil, "effectType is not a valid preset");
    if v7 then
        assert(typeof(v7) == "number", "speed is not a number");
    end;
    if v8 then
        assert(typeof(v8) == "number", "size is not a number");
    end;
    if v10 then
        local v13 = true;
        if typeof(v10) ~= "ColorSequence" then
            v13 = typeof(v10) == "Color3";
        end;
        assert(v13, "customColor is not a ColorSequence or Color3");
    end;
    if v11 then
        local v14 = true;
        if typeof(v11) ~= "NumberSequence" then
            v14 = typeof(v11) == "number";
        end;
        assert(v14, "customTransparency is not a NumberSequence or number");
    end;
    local v15 = {
        IsPaused = false, 
        Diagnostic = "DIAGNOSTIC VALUE", 
        UIInstance = v5, 
        ResumesOnShown = v12 == nil or v12, 
        EffectObjects = {}, 
        SavedObjects = {}, 
        Connections = {}, 
        Speed = v7 or 0.007, 
        Size = v8 or 1
    };
    local function v16(v17) --[[ Line: 69 ]] --[[ Name: RecursiveAncestryChanged ]]
        -- upvalues: v2 (ref), v16 (copy), v15 (copy)
        if not v17 then
            return;
        elseif v17:IsA("PlayerGui") or v17:IsA("Workspace") then
            return;
        else
            local v18 = v2[v17.ClassName];
            if not v18 then
                v16(v17.Parent);
                return;
            else
                table.insert(v15.Connections, v17:GetPropertyChangedSignal(v18):Connect(function() --[[ Line: 86 ]]
                    -- upvalues: v15 (ref), v17 (copy), v18 (copy)
                    v15.IsPaused = not v17[v18];
                    if v15.IsPaused then
                        v15:Pause();
                        return;
                    else
                        if v15.ResumesOnShown then
                            v15:Resume();
                        end;
                        return;
                    end;
                end));
                v16(v17.Parent);
                return;
            end;
        end;
    end;
    v16(v5);
    if v9 then
        for _, v20 in v5:GetChildren() do
            if v20:IsA("UIStroke") or v20:IsA("UIGradient") then
                table.insert(v15.SavedObjects, v20);
                v20.Parent = nil;
            end;
        end;
    end;
    local v21 = require(l_Presets_0:FindFirstChild(v6))(v5, v15.Speed, v15.Size, v10, v11);
    if v21.Connections then
        for _, v23 in v21.Connections do
            table.insert(v15.Connections, v23);
        end;
    end;
    if v21.Effects then
        for _, v25 in v21.Effects do
            table.insert(v15.EffectObjects, v25);
        end;
    end;
    v15.Connection = v5.AncestryChanged:Connect(function() --[[ Line: 124 ]]
        -- upvalues: v5 (copy), v15 (copy)
        if not v5:IsDescendantOf(game) then
            v15:Destroy();
        end;
    end);
    return (setmetatable(v15, v1));
end;
v1.Pause = function(v26) --[[ Line: 133 ]] --[[ Name: Pause ]]
    for _, v28 in v26.EffectObjects do
        if v28.Pause then
            v28:Pause();
        end;
    end;
end;
v1.Resume = function(v29) --[[ Line: 142 ]] --[[ Name: Resume ]]
    for _, v31 in v29.EffectObjects do
        if v31.Resume then
            v31:Resume();
        end;
    end;
end;
v1.Destroy = function(v32) --[[ Line: 151 ]] --[[ Name: Destroy ]]
    for _, v34 in v32.SavedObjects do
        v34.Parent = v32.UIInstance;
    end;
    for _, v36 in v32.Connections do
        v36:Disconnect();
    end;
    table.clear(v32.SavedObjects);
    table.clear(v32.Connections);
    for _, v38 in v32.EffectObjects do
        if v38.Destroy then
            v38:Destroy();
        end;
    end;
    v32.Connection:Disconnect();
end;
return table.freeze(v1);
