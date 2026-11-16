--!strict
--[[
	EggService
	Système d'ouverture d'œufs.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Remotes = require(Shared.Network.Remotes)
local EggConfig = require(Shared.Configs.Eggs)
local DataService = require(script.Parent.DataService)
local PetService = require(script.Parent.PetService)

local EggService = {}

function EggService:Init()
	Remotes.Get("OpenEgg").OnServerEvent:Connect(function(player, eggName)
		self:OpenEgg(player, eggName)
	end)
end

function EggService:Start()
end

function EggService:OpenEgg(player: Player, eggName: string)
	local data = DataService:Get(player)
	if not data then return end

	local egg = EggConfig[eggName]
	if not egg then return end

	if data.Currency < egg.Price then
		return -- Pas assez d'argent
	end

	-- Déduire le prix
	DataService:Update(player, function(d)
		d.Currency -= egg.Price
	end)

	-- Tirer un pet selon les poids
	local petId = self:RollPet(egg)
	PetService:GivePet(player, petId)

	Remotes.Get("EggOpened"):FireClient(player, eggName, petId)
	Remotes.Get("CurrencyUpdated"):FireClient(player, DataService:Get(player).Currency)
end

function EggService:RollPet(egg)
	local totalWeight = 0
	for _, weight in egg.Pets do
		totalWeight += weight
	end

	local roll = math.random() * totalWeight
	local current = 0
	for petId, weight in egg.Pets do
		current += weight
		if roll <= current then
			return petId
		end
	end
	return next(egg.Pets) -- fallback
end

return EggService
