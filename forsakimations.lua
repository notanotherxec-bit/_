local animationloader = loadstring(game:HttpGet("https://raw.githubusercontent.com/notanotherxec-bit/_/refs/heads/main/forceload.animation.lua"))()
local player = game.Players.LocalPlayer
local gui = player.PlayerGui

local function clearall()
	for _,child in ipairs(player:GetChildren()) do
		if child:IsA("Animation") then child:Destroy() end
	end

	for _,track in pairs(player.Character.Humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
		track:Destroy()
	end
end

local MainUI = gui.MainUI

local cloneui = MainUI.ShopScreen:Clone()
cloneui.Name="ForsakimationsMenu"
cloneui.Parent=MainUI
cloneui.Size=UDim2.new(1,-20,1,-20)
cloneui.Visible=true
local root = cloneui.ShopRoot
root.Name="ForsakimationsRoot"
local container = root.ShopContainer
container.Money:Destroy()
local Topbar = container.Topbar
for _,sub in ipairs(Topbar:GetChildren()) do if sub:IsA("ImageButton") and sub.Name~="Emotes" then sub:Destroy() end end
Topbar.Emotes.Size=UDim2.new(.5,0,0.65,0)
local Contents = container:WaitForChild("Contents")

local template = Contents.Noli:Clone() template.Name="Template"
template.Parent=game
template.Container.Price:Destroy()
template.Container.Title.Text="Template"
template.Container.Title.TextColor3=Color3.fromRGB(999,999,999)
template.Container.CharacterRender.Image="rbxassetid://71748174857033"
for _,sub in ipairs(Contents:GetChildren()) do if sub:IsA("Frame") then sub:Destroy() end end
--template.Parent=Contents

local emotesStorage = game.ReplicatedStorage.Assets.Emotes
for _,module in ipairs(emotesStorage:GetChildren()) do
	pcall(function()
		if module:IsA("ModuleScript") then
		local s,m = pcall(function() require(module) end)
		if s then
		local connected = require(module)
		local render = connected.RenderImage
		local id = connected.AssetID
		local sfx = nil
		if typeof(connected.SFX)=="string" then
			sfx=connected.SFX
		end

		local emotePad = template:Clone() emotePad.Name=connected.DisplayName
		emotePad.Container.CharacterRender.Image=render
		emotePad.Container.Title.Text=connected.DisplayName
		local dance_id = Instance.new("StringValue")
		dance_id.Parent = emotePad
		dance_id.Name="dance_id"
		dance_id.Value=tostring(id)
		emotePad.Parent=Contents
		--emotePad:SetAttribute(attribute, value)
		end
		end
	end)
end

for _,button in ipairs(Contents:GetChildren()) do
	if button:IsA("Frame") then
		local realButton = button.Container.Interact
		realButton.MouseButton1Click:Connect(function()
			local dance_id = button:FindFirstChild("dance_id")
			if dance_id then
			local rawid = string.sub(dance_id.Value,14,#dance_id.Value)
			clearall()
			warn(rawid,tonumber(rawid))
			local numid = tonumber(rawid)
				animationloader(numid)
			end
		end)
	end
end

local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode==Enum.KeyCode.X then
		cloneui.Visible = not cloneui.Visible
	end
end)

local sidebar = gui.MainUI.Sidebar
local frskm = sidebar.Buttons.Settings:Clone()
frskm.Name="Forsakimations"
frskm.Parent = sidebar.Buttons
frskm.Icon.Image="rbxassetid://93387041641721"
frskm.Button.MouseButton1Click:Connect(function()
	cloneui.Visible = not cloneui.Visible
end)
