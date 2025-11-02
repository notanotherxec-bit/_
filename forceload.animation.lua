return function(id)
  local animId = "rbxassetid://"..id
local animation = Instance.new("Animation")
animation.AnimationId=animId

local lp = game.Players.LocalPlayer
animation.Parent=lp
local track = lp.Character.Humanoid.Animator:LoadAnimation(animation)
track.Looped=true
track:Play()
end
