--!strict
--[[
	Bootstrap client
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local ControllersFolder = script:WaitForChild("Controllers")

local controllerNames = {
	"UIController",
	"InputController",
	"PetController",
}

local controllers = {}

for _, name in controllerNames do
	local module = ControllersFolder:FindFirstChild(name)
	if module then
		controllers[name] = require(module)
	end
end

for _, name in controllerNames do
	local ctrl = controllers[name]
	if ctrl and ctrl.Init then
		ctrl:Init()
	end
end

for _, name in controllerNames do
	local ctrl = controllers[name]
	if ctrl and ctrl.Start then
		ctrl:Start()
	end
end

print("[Client] All controllers started.")
