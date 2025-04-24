--@ kiwi_api.lua

if game.PlaceId ~= 70876832253163 then
	return
end

_G.KiwiAPI = {}

local Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer

Money_Bag_ID = "rbxassetid://125817164246802"

Money_Bag = game:GetObjects(Money_Bag_ID)[1]
Money_Bag:Destroy()

_G.KiwiAPI.MakeSellable = function(object: Model, amount: number)
	if object:IsA("Model") then
		object.PrimaryPart.Touched:Connect(function(hit: BasePart)
			if hit and hit.Name == "SellZone" then
				object.Parent = nil

				local Money_Bag: Model = game:GetObjects(Money_Bag_ID)[1]
				Money_Bag.Parent = workspace.RuntimeItems
				Money_Bag.MoneyBag.CFrame = hit.CFrame * CFrame.Angles(0, math.rad(90), 0) + Vector3.new(0, 3, 0)
				Money_Bag.MoneyBag.BillboardGui.TextLabel.Text = `${amount}`
				Money_Bag.MoneyBag.CollectPrompt.Triggered:Connect(function()
					Money_Bag.Parent = nil
					Money_Bag.MoneyBag.Collect:Play()
					LocalPlayer.leaderstats.Money.Value += amount
				end)
			end
		end)
	end
end

--@ dragging_system.lua

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage")
l_ReplicatedStorage_0:WaitForChild("Client"):WaitForChild("Handlers"):WaitForChild("DraggableItemHandlers"):WaitForChild("ClientDraggableObjectHandler").Enabled = false
local l_Players_0 = game:GetService("Players")
local l_RunService_0 = game:GetService("RunService")
local v7 = require(l_ReplicatedStorage_0.Shared.Remotes)
local l_RequestStartDrag_0 = v7.Events.RequestStartDrag
local l_UpdateDrag_0 = v7.Events.UpdateDrag
local l_RequestStopDrag_0 = v7.Events.RequestStopDrag
local l_RequestWeld_0 = v7.Events.RequestWeld
local l_RequestUnweld_0 = v7.Events.RequestUnweld
local v13 = require(l_ReplicatedStorage_0.Shared.SharedConstants.FeatureFlags)
local l_HoveringObject_0 = l_ReplicatedStorage_0.Client.Handlers.DraggableItemHandlers.ClientDraggableObjectHandler:FindFirstChild("HoveringObject")
local l_DraggingObject_0 = l_ReplicatedStorage_0.Client.Handlers.DraggableItemHandlers.ClientDraggableObjectHandler:FindFirstChild("DraggingObject")
local v17 = require(l_ReplicatedStorage_0.Client.Controllers.ActionController)
local v18 = require(l_ReplicatedStorage_0.Client.Controllers.ActionController.InputCategorizer)
local v19 = require(l_ReplicatedStorage_0.Shared.Utils.DraggableObjectUtil)
local v20 = require(l_ReplicatedStorage_0.Shared.Utils.TagUtil)
local v21 = require(l_ReplicatedStorage_0.Shared.SharedConstants.Tag)
local v22 = require(l_ReplicatedStorage_0.Client.DataBanks.ActionData)
local v23 = require(l_ReplicatedStorage_0.Client.Handlers.DraggableItemHandlers.ClientDraggableObjectHandler.RotationGizmo)
local l_isValidDraggableObject_0 = v19.isValidDraggableObject
local l_isValidWeldTarget_0 = v19.isValidWeldTarget
local l_isDraggableObjectWelded_0 = v19.isDraggableObjectWelded
local l_findFirstAncestorOfClassWithTag_0 = v20.findFirstAncestorOfClassWithTag
local l_LocalPlayer_0 = l_Players_0.LocalPlayer
local l_CurrentCamera_0 = workspace.CurrentCamera
local l_DragHighlight_0 = l_ReplicatedStorage_0.Client.Handlers.DraggableItemHandlers.ClientDraggableObjectHandler:FindFirstChild("DragHighlight")
local v32 = false
local v33 = nil
local v34 = nil
local v35 = nil
local v36 = nil
local v37 = false
local v38 = 0
local l_X_0 = Enum.Axis.X
local v40 = nil
local v41 = nil
local v42 = nil
local v43 = nil
local v44 = nil
local function raycastInFrontOfCamera()
	local l_Position_0 = l_CurrentCamera_0.CFrame.Position
	local v46 = l_CurrentCamera_0.CFrame.LookVector * 10
	local v47 = RaycastParams.new()
	v47.FilterType = Enum.RaycastFilterType.Exclude
	v47.FilterDescendantsInstances = {
		l_LocalPlayer_0.Character
	}
	return workspace:Raycast(l_Position_0, v46, v47)
end
local function getDraggableObjectInFrontOfCamera()
	local v49 = raycastInFrontOfCamera()
	if v49 and v49.Instance then
		local v50 = l_findFirstAncestorOfClassWithTag_0(v49.Instance, "Model", v21.DraggableObject)
		if v50 and l_isValidDraggableObject_0(v50) then
			if not v32 and v36 then
				v36.Enabled = l_HoveringObject_0.Value == v50
			end
			v36 = v50:FindFirstChild("ObjectInfo")
			return v50
		end
	elseif v36 then
		v36.Enabled = false
		v36 = nil
	end
	return nil
end
local function getWeldTargetTouchingObject(v52)
	if not v52 then
		return nil
	else
		local l_v52_BoundingBox_0 = v52:GetBoundingBox()
		local l_v52_ExtentsSize_0 = v52:GetExtentsSize()
		local v55 = OverlapParams.new()
		v55.FilterType = Enum.RaycastFilterType.Exclude
		v55.FilterDescendantsInstances = {
			v52
		}
		local l_workspace_PartBoundsInBox_0 = workspace:GetPartBoundsInBox(l_v52_BoundingBox_0, l_v52_ExtentsSize_0 * 1.05, v55)
		local v57 = nil
		for _, v59 in l_workspace_PartBoundsInBox_0 do
			if v59:IsA("BasePart") and l_isValidWeldTarget_0(v59) then
				return v59
			end
		end
		return v57
	end
end
local function requestStopDrag()
	if v33 and v33.PrimaryPart then
		l_RequestStopDrag_0:FireServer()
		if v43 then
			v43:Destroy()
		end
		if v44 then
			v44:Destroy()
		end
		if v42 then
			v42:Destroy()
		end
	end
	if l_DragHighlight_0 then
		l_DragHighlight_0.Adornee = nil
	end
	v32 = false
	v33 = nil
	v43 = nil
	v44 = nil
	v42 = nil
	v37 = false
	v38 = 0
	v40 = nil
	if v41 then
		v41:destroy()
	end
end
local function onServerDragRequestResponse(v86, v88)
	if not v86 or not l_isValidDraggableObject_0(v88) then
		v32 = false
		v33 = nil
		return
	else
		v32 = true
		v33 = v88
		v37 = false
		v41 = v23.new(v88)
		if not v13.Experimental.ServerOwnedDragging then
			if v88:HasTag(v21.RopedObject) then
				return
			else
				v42 = Instance.new("Attachment")
				v43 = Instance.new("AlignPosition")
				v44 = Instance.new("AlignOrientation")
				if v33 and v42 and v43 and v44 then
					v42.Name = "DragAttachment"
					v42.Parent = v33.PrimaryPart
					v43.Name = "DragAlignPosition"
					v43.Mode = Enum.PositionAlignmentMode.OneAttachment
					v43.ApplyAtCenterOfMass = false
					v43.MaxForce = 100000
					v43.Responsiveness = 50
					v43.Attachment0 = v42
					v43.Parent = v33.PrimaryPart
					v43.Position = v33.PrimaryPart.Position
					v44.Name = "DragAlignOrientation"
					v44.Mode = Enum.OrientationAlignmentMode.OneAttachment
					v44.MaxTorque = 10000
					v44.Responsiveness = 50
					v44.Attachment0 = v42
					v44.Parent = v33.PrimaryPart
				end
			end
		end
		return
	end
end
local function handleDragAction(_, v69, v70)
	if v18.getLastInputCategory() == "Gamepad" and v70.UserInputType == Enum.UserInputType.MouseButton1 then
		return Enum.ContextActionResult.Pass
	else
		if v69 == Enum.UserInputState.Begin then
			if v34 then
				if l_isDraggableObjectWelded_0(v34) then
					return Enum.ContextActionResult.Pass
				else
					local l_v34_0 = v34
					if not v32 and l_LocalPlayer_0.Character then
						onServerDragRequestResponse(true, l_v34_0)
						l_RequestStartDrag_0:FireServer(l_v34_0)
					end
					return Enum.ContextActionResult.Sink
				end
			end
		elseif v69 == Enum.UserInputState.End and v32 then
			requestStopDrag()
			return Enum.ContextActionResult.Sink
		end
		return Enum.ContextActionResult.Pass
	end
end
local function handleWeldAction(_, v74)
	if v74 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	elseif v32 then
		if v35 then
			l_RequestWeld_0:FireServer(v33, v35)
		end
		return Enum.ContextActionResult.Pass
	else
		if v34 then
			l_RequestUnweld_0:FireServer(v34)
		end
		return Enum.ContextActionResult.Sink
	end
end
local function handleSwitchAxisAction(_, v77)
	if v77 == Enum.UserInputState.Begin then
		if l_X_0 == Enum.Axis.X then
			l_X_0 = Enum.Axis.Y
		elseif l_X_0 == Enum.Axis.Y then
			l_X_0 = Enum.Axis.Z
		elseif l_X_0 == Enum.Axis.Z then
			l_X_0 = Enum.Axis.X
		end
		if v41 then
			v41:setCurrentAxis(l_X_0)
		end
		v38 = tick()
		return Enum.ContextActionResult.Sink
	else
		return Enum.ContextActionResult.Pass
	end
end
local function updateDrag(v79)
	if not v32 or not v33 or not v33.PrimaryPart then
		return
	else
		local l_CFrame_0 = l_CurrentCamera_0.CFrame
		local l_LookVector_0 = l_CFrame_0.LookVector
		local v82 = l_CFrame_0.Position + l_LookVector_0 * 10
		local l_v33_Pivot_0 = v33:GetPivot()
		if v17.isBound(v22.Action.RotateObject) and v17.isPressed(v22.Action.RotateObject) then
			v37 = true
			v38 = tick()
			if not v40 then
				v40 = l_v33_Pivot_0 - l_v33_Pivot_0.Position
			elseif v40 then
				local v84 = v79 * 4
				if l_X_0 == Enum.Axis.X then
					v40 = v40 * CFrame.Angles(v84, 0, 0)
				elseif l_X_0 == Enum.Axis.Y then
					v40 = v40 * CFrame.Angles(0, v84, 0)
				elseif l_X_0 == Enum.Axis.Z then
					v40 = v40 * CFrame.Angles(0, 0, v84)
				end
			end
		end
		if v13.Experimental.ServerOwnedDragging or v33:HasTag(v21.RopedObject) then
			l_UpdateDrag_0:FireServer(l_LookVector_0, v82)
			return
		else
			if v43 and v44 then
				v43.Position = v82
				if not v37 then
					v44.CFrame = CFrame.new(v82, v82 + l_LookVector_0)
					return
				else
					v44.CFrame = CFrame.new(v82) * v40
				end
			end
			return
		end
	end
end
local function updateInteractionText()
	local l_Character_0 = l_LocalPlayer_0.Character
	if not l_Character_0 then
		return
	else
		local l_Humanoid_0 = l_Character_0:FindFirstChildOfClass("Humanoid")
		if not l_Humanoid_0 or l_Humanoid_0 and l_Humanoid_0.Sit then
			return
		else
			local v95 = false
			local v96 = false
			local v97 = false
			local v98 = "Drag"
			local v99 = "Weld"
			if v32 then
				v98 = "Drop"
				v95 = true
				v97 = true
				if v35 then
					v96 = true
				end
			elseif v34 then
				if l_isDraggableObjectWelded_0(v34) then
					v99 = "Unweld"
					v96 = true
				else
					v95 = true
				end
			end
			if v34 and v34:GetAttribute("OwnerId") and v34:GetAttribute("OwnerId") ~= l_LocalPlayer_0.UserId then
				v95 = false
			end
			if v17.isBound(v22.Action.DragObject) ~= v95 then
				if v95 then
					v17.bindAction(v22.Action.DragObject, handleDragAction, v22.ActionContext[v22.Action.DragObject], Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonR2, v22.ActionPriority.High)
				else
					v17.unbindAction(v22.Action.DragObject)
				end
			end
			if v17.isBound(v22.Action.RotateObject) ~= v97 then
				if v97 then
					v17.bindAction(v22.Action.RotateObject, v22.noOp, v22.ActionContext[v22.Action.RotateObject], Enum.KeyCode.R, Enum.KeyCode.ButtonL2, v22.ActionPriority.Low)
				else
					v17.unbindAction(v22.Action.RotateObject)
				end
			end
			if v17.isBound(v22.Action.ChangeRotationAxis) ~= v97 then
				if v97 then
					v17.bindAction(v22.Action.ChangeRotationAxis, handleSwitchAxisAction, v22.ActionContext[v22.Action.ChangeRotationAxis], Enum.KeyCode.T, Enum.KeyCode.ButtonY, v22.ActionPriority.Low)
				else
					v17.unbindAction(v22.Action.ChangeRotationAxis)
				end
			end
			if v96 ~= v17.isBound(v22.Action.WeldObject) then
				if v96 then
					v17.bindAction(v22.Action.WeldObject, handleWeldAction, v22.ActionContext[v22.Action.WeldObject], Enum.KeyCode.Z, Enum.KeyCode.ButtonX, v22.ActionPriority.Medium)
				else
					v17.unbindAction(v22.Action.WeldObject)
				end
			end
			if v17.isBound(v22.Action.DragObject) then
				v17.setButtonText(v22.Action.DragObject, v98)
			end
			if v17.isBound(v22.Action.WeldObject) then
				v17.setButtonText(v22.Action.WeldObject, v99)
			end
			return
		end
	end
end
local function updateVisuals()
	if v32 and v33 then
		l_DragHighlight_0.Adornee = v33
		if v33:HasTag("ShopItem") then
			l_DragHighlight_0.OutlineColor = Color3.fromRGB(255, 247, 0)
		else
			l_DragHighlight_0.OutlineColor = Color3.fromRGB(255, 255, 255)
		end
		if v41 then
			v41:setParent(l_CurrentCamera_0)
		end
	elseif v34 then
		l_DragHighlight_0.Adornee = v34
		if v34:HasTag("ShopItem") then
			l_DragHighlight_0.OutlineColor = Color3.fromRGB(255, 247, 0)
		else
			l_DragHighlight_0.OutlineColor = Color3.fromRGB(255, 255, 255)
		end
		if v41 then
			v41:setParent(nil)
		end
	else
		l_DragHighlight_0.Adornee = nil
		if v41 then
			v41:setParent(nil)
		end
	end
	if v41 then
		if tick() > v38 + 1.5 then
			v41:hide()
			return
		else
			v41:show()
		end
	end
end
l_RequestWeld_0.OnClientEvent:Connect(function(v102)
	if v102 then
		requestStopDrag()
	end
end)
l_RunService_0.RenderStepped:Connect(function(v103)
	v34 = getDraggableObjectInFrontOfCamera()
	v35 = getWeldTargetTouchingObject(l_DraggingObject_0.Value)
	updateDrag(v103)
	updateInteractionText()
	updateVisuals()
	l_HoveringObject_0.Value = if v34 ~= v33 then v34 else nil
	l_DraggingObject_0.Value = v33
end)
