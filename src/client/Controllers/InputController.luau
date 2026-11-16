--!strict
--[[
	InputController
	Gère les clics / inputs du joueur.
]]

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = require(Shared.Network.Remotes)

local InputController = {}

function InputController:Init()
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			Remotes.Get("Click"):FireServer()
		end
	end)
end

function InputController:Start()
end

return InputController
