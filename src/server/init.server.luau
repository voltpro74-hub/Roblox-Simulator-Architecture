--!strict
--[[
	Bootstrap serveur
	Charge et initialise tous les Services dans l'ordre correct.
]]

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local ServicesFolder = script:WaitForChild("Services")

-- Création des Remotes en premier
local Remotes = require(Shared.Network.Remotes)
Remotes.Init()

-- Liste ordonnée des services (ordre d'initialisation important)
local serviceNames = {
	"DataService",
	"EconomyService",
	"PetService",
	"EggService",
	"RebirthService",
}

local services = {}

-- Phase 1 : Require
for _, name in serviceNames do
	local module = ServicesFolder:FindFirstChild(name)
	if module then
		services[name] = require(module)
	end
end

-- Phase 2 : Init (parallèle possible, ici séquentiel pour clarté)
for _, name in serviceNames do
	local service = services[name]
	if service and service.Init then
		service:Init()
	end
end

-- Phase 3 : Start
for _, name in serviceNames do
	local service = services[name]
	if service and service.Start then
		service:Start()
	end
end

print("[Server] All services started successfully.")
