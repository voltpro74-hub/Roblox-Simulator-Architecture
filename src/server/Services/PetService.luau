--!strict
--[[
	PetService
	Gestion des pets (équipement, multiplicateurs, inventaire).
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Remotes = require(Shared.Network.Remotes)
local PetConfig = require(Shared.Configs.Pets)
local DataService = require(script.Parent.DataService)

local PetService = {}

function PetService:Init()
	Remotes.Get("EquipPet").OnServerEvent:Connect(function(player, petId)
		self:EquipPet(player, petId)
	end)
end

function PetService:Start()
end

function PetService:EquipPet(player: Player, petId: string)
	local data = DataService:Get(player)
	if not data then return end

	-- Validation basique
	if not data.Pets[petId] then
		return
	end

	data.EquippedPet = petId
	-- Recalculer multipliers si besoin
	Remotes.Get("PetEquipped"):FireClient(player, petId)
end

function PetService:GivePet(player: Player, petId: string)
	DataService:Update(player, function(data)
		data.Pets[petId] = true
	end)
end

return PetService
